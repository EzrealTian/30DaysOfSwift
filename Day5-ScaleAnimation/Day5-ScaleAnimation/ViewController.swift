//
//  ViewController.swift
//  Day5-ScaleAnimation
//
//  Created by 田逸昕 on 2020/1/15.
//  Copyright © 2020 田逸昕. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var pictureList = ["picture-1", "picture-2", "picture-3", "picture-4", "picture-5"]
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
    }


}

extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pictureList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ImageCollectionViewCell
        cell.imageView.image = UIImage(named: pictureList[indexPath.row])
        cell.titleLabel.text = pictureList[indexPath.row]
        cell.layer.transform = animateCell(cellFrame: cell.frame)
        cell.layer.cornerRadius = 10
        cell.clipsToBounds = true
        return cell
    }
    
    
}

extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let collectionView = scrollView as? UICollectionView {
            //确定每个可见的单元格的坐标
            for cell in collectionView.visibleCells as! [ImageCollectionViewCell] {
                //确定是第几格
                let indexPath = collectionView.indexPath(for: cell)!
                //获得单元格属性
                let attributes = collectionView.layoutAttributesForItem(at: indexPath)!
                //从属性中获得坐标，大小的frame
                let cellFrame = collectionView.convert(attributes.frame, to: view)
                //偏移的长度，设定为当前X坐标/5
                let translationX = cellFrame.origin.x / 5
                //通过transform函数来让背景图片进行偏移
                //cell.coverImageView.transform = CGAffineTransform(translationX: translationX, y: 0)
                cell.layer.transform = animateCell(cellFrame: cellFrame)
                print(cellFrame)
            }
        }
    }
    
    //单元格动画函数
    func animateCell(cellFrame: CGRect) -> CATransform3D {
        ///偏置动画
        //使用 X 位置将其转换为视角角度，数字越小，角度越尖
        let angleFromX = Double((-cellFrame.origin.x) / 10)
        let angle = CGFloat((angleFromX * Double.pi) / 180.0)
        //自定义 转换 矩阵的值
        var transform = CATransform3DIdentity
        transform.m34 = -1.0/1000
        //将角度和转换应用到 CATransform3DRotate
        let rotation = CATransform3DRotate(transform, angle, 0, 1, 0)
        
        ///缩放动画
        var scaleFromX = (1000 - (cellFrame.origin.x - 200)) / 1000
        let scaleMax: CGFloat = 1.0
        let scaleMin: CGFloat = 0.6
        if scaleFromX > scaleMax {
            scaleFromX = scaleMax
        }
        if scaleFromX < scaleMin {
            scaleFromX = scaleMin
        }
        let scale = CATransform3DScale(CATransform3DIdentity, scaleFromX, scaleFromX, 1)
        
        return CATransform3DConcat(rotation, scale)
    }
}


extension ViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - CGFloat(20)
        let height = collectionView.frame.height - CGFloat(40)
        return CGSize(width: width, height: height)
    }
}
