//
//  ViewController.swift
//  Day8-RandomGradientColorMusic
//
//  Created by 田逸昕 on 2020/2/5.
//  Copyright © 2020 田逸昕. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    var timer: Timer?   //定时器
    var gradientLayer = CAGradientLayer()
    var audioPlayer = AVAudioPlayer()

    override func viewDidLoad() {
        super.viewDidLoad()
        gradientLayer.frame = self.view.bounds
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 1, y: 1)
        self.view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    /// 隐藏状态栏
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    @IBAction func playAction(_ sender: Any) {
        if timer == nil {   //判断播放状态
            self.playMusic(name: "横竖撇点折-泠鸢（Cover：米白）")
            timer = Timer.scheduledTimer(withTimeInterval: 0.2, repeats: true, block: { (timer) in
                self.changeColor()
            })
        } else {
            audioPlayer.pause()
            timer?.invalidate()
            timer = nil
        }
    }
    
    /// 更换layer层颜色
    func changeColor() {
        let red: CGFloat = CGFloat(drand48())
        let green: CGFloat = CGFloat(drand48())
        let blue: CGFloat = CGFloat(drand48())
        let color1 = UIColor(displayP3Red: red, green: green, blue: blue, alpha: 1)
        let color2 = UIColor(displayP3Red: green, green: red, blue: blue, alpha: 1)
        self.gradientLayer.colors = [color1.cgColor, color2.cgColor]
    }
    
    /// 播放音乐
    /// - parameter name: 文件名
    func playMusic(name: String) {
        if audioPlayer.rate == 0 {  //rate为0说明之前并未播放，需要初始化
            do {
                let path = Bundle.main.path(forResource: name, ofType: "mp4")
                //字符串path转换成url
                let url = URL(fileURLWithPath: path!)
                //对音频播放对象进行初始化，并加载指定的音频文件
                try audioPlayer = AVAudioPlayer(contentsOf: url)
                audioPlayer.prepareToPlay()
                //设置音频的播放次数，-1为无限循环
                audioPlayer.numberOfLoops = -1
                //开始播放
                audioPlayer.play()
            } catch {
                print(error)
            }
        } else {    //恢复播放
            audioPlayer.play()
        }
    }
}

