//
//  ViewController.swift
//  Day9-ImageZoomEffect
//
//  Created by 田逸昕 on 2020/2/5.
//  Copyright © 2020 田逸昕. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let scrollView = ImageZoomView(frame: self.view.frame)
        scrollView.imgView.image = UIImage(named: "picture")
        self.view.addSubview(scrollView)
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}

