//
//  ViewController.swift
//  Day2-CustomFonts
//
//  Created by 田逸昕 on 2020/1/12.
//  Copyright © 2020 田逸昕. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var fontTableView: UITableView!  //表格
    
    var fontFamily = ["Indie Flower", "LongCang-Regular", "DFWaWaSC-W5"]  //存放自定义的字体名称（需提前在info.plist文件配置
    var fontIndex = 0   //当前字体序号
    var text = [    //文本内容
        "30 Days Of Swift",
        "本项目使用字体仅作为示例",
        "均来源于macOS以及Google Font",
        "这是第二个project，加油嗷",
        "有兴趣的可以关注我的网站和GitHub",
        "www.ezreal-tian.com && github.com/EzrealTian",
        "会持续更新内容",
        "🐛🐛🐛"
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fontTableView.delegate = self   //设置代理
        fontTableView.dataSource = self //设置数据源
        self.title = fontFamily[fontIndex]
    }

    /// 改变字体
    @IBAction func changeFontAction(_ sender: Any) {
        fontIndex = (fontIndex + 1) % 3 //序号取模
        fontTableView.reloadData()  //表格重新加载
        self.title = fontFamily[fontIndex]  //当前导航栏更改为当前字体名
    }
    
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    /// 表格行数
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return text.count
    }
    
    /// 表格内容
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "fontCell", for: indexPath)
        cell.textLabel?.text = text[indexPath.row]
        cell.textLabel?.font = UIFont(name: fontFamily[fontIndex], size: 16)    //设置字体
        print(fontFamily[fontIndex])
        return cell
    }
    
    
}
