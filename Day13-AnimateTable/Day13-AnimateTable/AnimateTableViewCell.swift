//
//  AnimateTableViewCell.swift
//  Day13-AnimateTable
//
//  Created by 田逸昕 on 2020/2/8.
//  Copyright © 2020 田逸昕. All rights reserved.
//

import UIKit

class AnimateTableViewCell: UITableViewCell {
    
    let gradientLayer = CAGradientLayer()
    
    //颜色值
    var colorValue: CGFloat? {
        didSet {
            self.backgroundColor = UIColor(displayP3Red: 1, green: self.colorValue!, blue: 0.3, alpha: 1)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        //字体
        self.textLabel?.textColor = .white
        self.textLabel?.font = UIFont(name: "Helvetica", size: 18)
        //分界处渐变白色分割线
        let color1 = UIColor(white: 1, alpha: 0.1).cgColor
        let color2 = UIColor.clear.cgColor
        let color3 = UIColor(white: 0.8, alpha: 0.1).cgColor
        gradientLayer.colors = [color1, color2, color3] //颜色集
        gradientLayer.locations = [0, 0.95, 1]  //渐变起始位置
        gradientLayer.frame = self.bounds
        self.layer.addSublayer(gradientLayer)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}


