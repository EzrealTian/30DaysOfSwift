//
//  ViewController.swift
//  Day1-StopWatch
//
//  Created by 田逸昕 on 2020/1/11.
//  Copyright © 2020 田逸昕. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var startButton: UIButton!   //开始button
    @IBOutlet weak var pauseButton: UIButton!   //暂停button
    @IBOutlet weak var resetButton: UIButton!   //重置按钮
    @IBOutlet weak var timeLabel: UILabel!  //显示时间的label
    
    private var minusSecond = 0 //毫秒
    private var second = 0  //秒
    private var minute = 0  //分钟
    private var timer : Timer?  // 定时器
    
    var backgroundTask: UIBackgroundTaskIdentifier = .invalid   //后台任务标签
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(reinstateBackgroundTask), name: UIApplication.didBecomeActiveNotification, object: nil)    //添加观察者
    }
    
    deinit {
      NotificationCenter.default.removeObserver(self)
    }

    /// 开始计时
    @IBAction func startAction(_ sender: Any) {
        startButton.isEnabled = false   //点击之后开始按钮不可用
        pauseButton.isEnabled = true    //暂停按钮可用
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)   //每隔0.01秒执行一次目标函数
        registerBackgroundTask()    //后台任务注册
    }
    
    /// 暂停计时
    @IBAction func pauseAction(_ sender: Any) {
        timer?.invalidate() //移除计时器
        timer = nil //释放内存
        startButton.isEnabled = true    //开始按钮可用
        pauseButton.isEnabled = false   //暂停按钮不可用
        if backgroundTask != .invalid { //暂停释放后台任务
            endBackgroundTask()
        }
    }
    
    /// 计时重置
    @IBAction func resetAction(_ sender: Any) {
        timer?.invalidate() //移除y计时器
        timeLabel.text = "00:00.0" //label更新
        minusSecond = 0
        second = 0
        minute = 0
        startButton.isEnabled = true    //开始按钮可用
        pauseButton.isEnabled = false   //暂停按钮不可用
    }
    
    @objc func updateTime() {
        minusSecond += 1    //毫秒递增
        if minusSecond == 10 { //毫秒进位
            minusSecond = 0
            second += 1
        }
        if second == 60 {   //秒进位
            second = 0
            minute += 1
        }
        timeLabel.text = String(format:"%02d:%02d.%d", minute, second, minusSecond)   //更新label
        
//        if UIApplication.shared.applicationState == .background {
//            //timeLabel.text = String(format:"%02d:%02d.%02d", minute, second, minusSecond)   //更新label
//            //print(String(format:"%02d:%02d.%d", minute, second, minusSecond))
//            print(UIApplication.shared.backgroundTimeRemaining)
//        }
    }

    /// 注册后台任务
    func registerBackgroundTask() {
        backgroundTask = UIApplication.shared.beginBackgroundTask(expirationHandler: {
            self.endBackgroundTask()
        })
        assert(backgroundTask != .invalid)
    }
    
    /// 后台任务结束
    func endBackgroundTask() {
        UIApplication.shared.endBackgroundTask(backgroundTask)
        backgroundTask = .invalid
    }

    /// 重新获取后台时间
    @objc func reinstateBackgroundTask() {
      if timer != nil && (backgroundTask == .invalid) {
        registerBackgroundTask()
      }
    }
}

