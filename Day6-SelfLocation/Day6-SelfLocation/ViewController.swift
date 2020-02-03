//
//  ViewController.swift
//  Day6-SelfLocation
//
//  Created by 田逸昕 on 2020/1/21.
//  Copyright © 2020 田逸昕. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController {
    
    @IBOutlet weak var placeCollectionView: UICollectionView!   // 底部地点选择collectionView
    @IBOutlet weak var imageView: UIImageView!  //所选地点图片
    @IBOutlet weak var placeLocationLabel: UILabel! //所选地点名称
    @IBOutlet weak var selfLocationLabel: UILabel!  //当前地点
    @IBOutlet weak var distanceLabel: UILabel!  //当前地点与所选地点距离
    
    
    var placeList: [FamousPlace] = []   //地点信息数组
    var locationManager: CLLocationManager? //location管理
    var currentLocation: CLLocation?    //当前location
    var selectedPlace: FamousPlace? //当前选中地点
    lazy var geocoder = CLGeocoder()    //地点解析器

    override func viewDidLoad() {
        super.viewDidLoad()
        loadPlaces()    //从plist文件加载地点信息
        placeCollectionView.delegate = self //设置代理
        placeCollectionView.dataSource = self   //设置数据源
        locationManager = CLLocationManager()   //初始化locationManager
        locationManager?.delegate = self    //设置location代理
        locationManager?.desiredAccuracy = kCLLocationAccuracyHundredMeters //精确度
        locationManager?.allowsBackgroundLocationUpdates = true //允许后台运行获取位置
        if CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse {    //启动位置更新服务
            locationManager?.startUpdatingLocation()
        } else {
            locationManager?.requestAlwaysAuthorization()
        }
        selectedPlace = placeList[0]
        updateUI()  //初始化UI
    }
    
    /// 选中按钮触发事件
    @IBAction func selectPlace(_ sender: Any) {
        let index = (sender as! UIButton).tag
        selectedPlace = placeList[index]
        updateUI()
    }
    
    /// 更新UI
    private func updateUI() {
        if let image = UIImage(named: selectedPlace!.imageName) {
            imageView.image = image
        }
        placeLocationLabel.text = selectedPlace?.name
        locationToPlace(location: currentLocation)
        guard let place = currentLocation, let distanceInMeters = selectedPlace?.location.distance(from: place) else { return }
        let distance = Measurement(value: distanceInMeters, unit: UnitLength.meters)    //获取距离
        let kilometers = distance.converted(to: .kilometers)
        distanceLabel.text = "当前距离：" + String(format: "%.2lf", kilometers.value) + "千米"
    }
    
    /// 将location转化为地址字符串
    /// - parameter location: 地址
    private func locationToPlace(location: CLLocation?) {
        var locationStr = ""
        guard let place = location else { return }
        geocoder.reverseGeocodeLocation(place) {
            [weak self] (placemarks, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let placemark = placemarks?.first else { return }
            if let country = placemark.country { locationStr += country }
            if let province = placemark.administrativeArea { locationStr += province}
            if let locality = placemark.locality { locationStr += locality }
            if let subLocality = placemark.subLocality { locationStr += subLocality}
            if let thoroughfare = placemark.thoroughfare { locationStr += thoroughfare}
            //            print(placemark.country)    //国家
            //            print(placemark.administrativeArea) //省
            //            print(placemark.locality)   //市
            //            print(placemark.subLocality)    //区
            //            print(placemark.name)   //地址名
            //            print(placemark.subAdministrativeArea)
            //            print(placemark.thoroughfare)   //街道名
            //            print(placemark.subThoroughfare)    //街道号
            self?.selfLocationLabel.text = "当前位置：" + locationStr
        }
    }
    
    /// 加载place数组
    private func loadPlaces() {
        //从字典数组获得数据
        guard let entries = loadPlist(fileName: "Place") else { fatalError("Unable to load data") }
        //初始化place数组
        for property in entries {
            guard let name = property["Name"] as? String,
                let latitude = property["Latitude"] as? NSNumber,
                let longitude = property["Longitude"] as? NSNumber,
                let image = property["Image"] as? String
                else { fatalError("Error reading data") }
            let place = FamousPlace(latitude: latitude.doubleValue, longitude: longitude.doubleValue, name: name, imageName: image)
            placeList.append(place)
        }
    }

    /// 加载plist文件
    /// - parameter fileName: 文件名
    /// - returns: [[String: Any]]? 地点的字典数组形式
    private func loadPlist(fileName: String) -> [[String: Any]]? {
        guard let plistUrl = Bundle.main.url(forResource: fileName, withExtension: "plist"),
            let plistData = try? Data(contentsOf: plistUrl) else { return nil }
        var placedEntries: [[String: Any]]? = nil
        do {
            placedEntries = try PropertyListSerialization.propertyList(from: plistData, options: [], format: nil) as? [[String: Any]]
        } catch {
            print("error reading plist")
        }
        return placedEntries
    }
}


extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return placeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PlaceCell", for: indexPath) as! PlaceCollectionViewCell
        if let image = UIImage(named: placeList[indexPath.row].imageName) {
            cell.placeButton.setImage(image, for: .normal)  //设置按钮图片
            cell.placeButton.imageView?.contentMode = .scaleAspectFill  //按钮图片缩放模式
            cell.placeButton.tag = indexPath.row    //设置按钮tag
        }
        return cell
    }
}


extension ViewController: CLLocationManagerDelegate {
    /// 权限改变的时候更新定位服务
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager?.startUpdatingLocation()
        } else {
            locationManager?.requestAlwaysAuthorization()
        }
    }
    
    /// 定位失败
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }
      
    /// 位置信息更新时更新当前位置并更新UI
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        currentLocation = locations.first
        updateUI()
    }
}
