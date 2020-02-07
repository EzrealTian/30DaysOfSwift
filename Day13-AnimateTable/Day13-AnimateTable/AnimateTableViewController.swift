//
//  AnimateTableViewController.swift
//  Day13-AnimateTable
//
//  Created by 田逸昕 on 2020/2/7.
//  Copyright © 2020 田逸昕. All rights reserved.
//

import UIKit

class AnimateTableViewController: UITableViewController {

    var tableData = ["赵客缦胡缨，吴钩霜雪明。",  "银鞍照白马，飒沓如流星。",
    "十步杀一人，千里不留行。", "事了拂衣去，深藏身与名。",
    "闲过信陵饮，脱剑膝前横。", "将炙啖朱亥，持觞劝侯嬴。",
    "三杯吐然诺，五岳倒为轻。", "眼花耳热后，意气素霓生。",
    "救赵挥金槌，邯郸先震惊。", "千秋二壮士，煊赫大梁城。",
    "纵死侠骨香，不惭世上英。", "谁能书閤下，白首太玄经。"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableData.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "animateCell", for: indexPath) as! AnimateTableViewCell
        cell.colorValue = (CGFloat(indexPath.row) / CGFloat(tableData.count)) * 0.6 //根据index颜色渐变
        cell.textLabel?.text = tableData[indexPath.row]
        return cell
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
        let cells = tableView.visibleCells
        let tableHeight: CGFloat = tableView.bounds.size.height
        for cell in cells {
            cell.transform = CGAffineTransform(translationX: 0, y: tableHeight) //所有单元格初始位置为界面底部
        }
        var index = 0
        for cell in cells {
            UIView.animate(withDuration: 1.5, delay: 0.05 * Double(index), usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: [], animations: {    //根据index每个后续单元格动画推迟执行
                cell.transform = CGAffineTransform(translationX: 0, y: 0);
            }, completion: nil)
            index += 1
        }
    }
}
