//
//  ViewController.swift
//  Day10-GameVideoBackground
//
//  Created by 田逸昕 on 2020/2/6.
//  Copyright © 2020 田逸昕. All rights reserved.
//

import UIKit
import AVFoundation
import AVKit

class ViewController: UIViewController {
    var playerController = AVPlayerViewController() //播放控制器

    override func viewDidLoad() {
        super.viewDidLoad()
        //定义一个视频文件路径
        let filePath = Bundle.main.path(forResource: "决战平安京", ofType: "mp4")
        let videoURL = URL(fileURLWithPath: filePath!)
        //定义一个视频播放器
        playerController.player = AVPlayer(url: videoURL)
        //设置视频缩放模式
        playerController.videoGravity = .resizeAspectFill
        //是否播放声音, 0~1
        playerController.player?.volume = 1
        //隐藏播放控制器
        playerController.showsPlaybackControls = false
        //设置播放器界面大小
        playerController.view.frame = self.view.frame
        //添加到界面上，置于最底层
        self.view.insertSubview(playerController.view, at: 0)
        //监听视频播放完成时重新播放
        NotificationCenter.default.addObserver(self, selector: #selector(playerDidFinishPlaying), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: playerController.player!.currentItem)
        //开始播放
        playerController.player!.play()
    }

    //视频播放完毕响应
    @objc func playerDidFinishPlaying() {
        // 回到视频初始点
        playerController.player!.seek(to: CMTime.zero)
        // 开始播放
        playerController.player!.play()
    }
}

