//
//  ViewController.swift
//  Day7-PullToRefresh
//
//  Created by 田逸昕 on 2020/2/3.
//  Copyright © 2020 田逸昕. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var emojiTableView: UITableView!
    
    let refreshControl = UIRefreshControl() //刷新控件
    
    let emojiGroup1 = ["😝😝😝😝😝😝", "😆😆😆😆😆😆", "🙃🙃🙃🙃🙃🙃", "🤪🤪🤪🤪🤪🤪", "🥺🥺🥺🥺🥺🥺", "🤤🤤🤤🤤🤤🤤"]
    let emojiGroup2 = ["🐔🐔🐔🐔🐔🐔", "🐶🐶🐶🐶🐶🐶", "🐮🐮🐮🐮🐮🐮", "🐷🐷🐷🐷🐷🐷", "🐴🐴🐴🐴🐴🐴", "🐻🐻🐻🐻🐻🐻"]
    var flag = 0    //数组标志位
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emojiTableView.delegate = self
        emojiTableView.dataSource = self
        
        emojiTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshEmoji), for: .valueChanged)
        refreshControl.backgroundColor = UIColor(red:0.113, green:0.113, blue:0.145, alpha:1)
        refreshControl.tintColor = UIColor.white
    }

    /// emoji刷新函数
    @objc func refreshEmoji() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {   //延迟一秒执行
            let dateformatter = DateFormatter()
            dateformatter.dateFormat = "HH:mm:ss"   // 自定义时间格式
            let time = dateformatter.string(from: Date())   //获取当前时间并转换
            let attributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            self.refreshControl.attributedTitle = NSAttributedString(string: "上次更新于 \(time)", attributes: attributes)
            self.flag += 1
            self.emojiTableView.reloadData()    //刷新表格
            self.refreshControl.endRefreshing() //刷新结束
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return flag % 2 == 0 ? emojiGroup1.count : emojiGroup2.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = flag % 2 == 0 ? emojiGroup1[indexPath.row] : emojiGroup2[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: 40)
        cell.textLabel?.textAlignment = .center
        return cell
    }
    
    
}

