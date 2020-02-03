//
//  FamousPlace.swift
//  Day6-SelfLocation
//
//  Created by 田逸昕 on 2020/1/21.
//  Copyright © 2020 田逸昕. All rights reserved.
//

import Foundation
import CoreLocation

class FamousPlace {
    let location: CLLocation    //地点经纬度
    let name: String    //名称
    let imageName: String   //图片名
    
    /// 初始化
    init(latitude: Double, longitude: Double, name: String, imageName: String) {
        self.location = CLLocation(latitude: latitude, longitude: longitude)
        self.name = name
        self.imageName = imageName
    }
}
