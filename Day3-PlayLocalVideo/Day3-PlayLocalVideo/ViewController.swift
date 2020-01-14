//
//  ViewController.swift
//  Day3-PlayLocalVideo
//
//  Created by 田逸昕 on 2020/1/13.
//  Copyright © 2020 田逸昕. All rights reserved.
//

import UIKit
import AVKit

class ViewController: UIViewController {
    
    @IBOutlet weak var videoTableView: UITableView!
    
    var videoName = ["video-3", "emoji zone", "video-2"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //设置代理和数据源
        videoTableView.delegate = self
        videoTableView.dataSource = self
    }

    /// 获取视频第一帧的缩略图
    /// - parameter fileName: 文件名
    /// - returns CGImage?: 视频第一帧缩略图
    /// - returns Double: 视频时长
    private func getImageAndDuration(fileName: String) -> (CGImage?, Int) {
        //初始化文件路径
        let filePath = Bundle.main.path(forResource: fileName, ofType: "mp4")
        let videoURL = URL(fileURLWithPath: filePath!)
        //初始化媒体文件
        let asset = AVURLAsset.init(url: videoURL, options: nil)
        //获取视频时长
        let duration = Int(asset.duration.seconds)
        //创建图片构造器
        let generator = AVAssetImageGenerator.init(asset: asset)
        //确保视频旋转时，获取到的图片是正向的
        generator.appliesPreferredTrackTransform = true
        //设定截取什么时候的图片，时间为0/100
        let time = CMTimeMakeWithSeconds(0, preferredTimescale: 100)
        var actualTime : CMTime = CMTimeMakeWithSeconds(0, preferredTimescale: 0)
        do {
            let image = try generator.copyCGImage(at: time, actualTime: &actualTime)
            return (image, duration)
        } catch  {
            print("错误")
        }
        return (nil, 0)
    }
    
    @objc func playVideo(btn: UIButton) {
        let cell = btn.superview?.superview as! VideoTableViewCell
        //初始化文件路径
        let filePath = Bundle.main.path(forResource: cell.nameLabel.text, ofType: "mp4")
        let videoURL = URL(fileURLWithPath: filePath!)
        //初始化播放器
        let player = AVPlayer(url: videoURL)
        let playerController = AVPlayerViewController()
        playerController.player = player
        present(playerController, animated: true) {
            player.play()
        }
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "videoCell", for: indexPath) as! VideoTableViewCell
        let imageAndDuration = getImageAndDuration(fileName: videoName[indexPath.row])
        cell.videoImage.image = UIImage(cgImage: imageAndDuration.0!)
        cell.nameLabel.text = videoName[indexPath.row]
        cell.durationLabel.text = String(imageAndDuration.1 / 60) + ":" + String(imageAndDuration.1 % 60)
        cell.playButton.addTarget(self, action: #selector(playVideo(btn:)), for: .touchUpInside)
        return cell
    }
    
    
}

