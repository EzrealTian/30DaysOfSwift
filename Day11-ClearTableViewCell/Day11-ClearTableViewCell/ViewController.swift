//
//  ViewController.swift
//  Day11-ClearTableViewCell
//
//  Created by 田逸昕 on 2020/2/6.
//  Copyright © 2020 田逸昕. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var tableData = ["赵客缦胡缨，吴钩霜雪明。",  "银鞍照白马，飒沓如流星。",
                     "十步杀一人，千里不留行。", "事了拂衣去，深藏身与名。",
                     "闲过信陵饮，脱剑膝前横。", "将炙啖朱亥，持觞劝侯嬴。",
                     "三杯吐然诺，五岳倒为轻。", "眼花耳热后，意气素霓生。",
                     "救赵挥金槌，邯郸先震惊。", "千秋二壮士，煊赫大梁城。",
                     "纵死侠骨香，不惭世上英。", "谁能书閤下，白首太玄经。"]

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    //隐藏状态栏
    override var prefersStatusBarHidden: Bool {
        return true
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "clearTableViewCell", for: indexPath) as! ClearTableViewCell
        cell.colorValue = (CGFloat(indexPath.row) / CGFloat(tableData.count)) * 0.6 //根据index颜色渐变
        cell.textLabel?.text = tableData[indexPath.row]
        return cell
    }
    
    
}
