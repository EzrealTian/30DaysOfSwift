//
//  ViewController.swift
//  Day14-EmojiMachine
//
//  Created by 田逸昕 on 2020/2/8.
//  Copyright © 2020 田逸昕. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Property
    @IBOutlet weak var emojiPickerView: UIPickerView!   // emoji选择器
    @IBOutlet weak var resultLabel: UILabel!    //结果label
    @IBOutlet weak var playButton: UIButton!    //play按钮
    
    let emojiGroup = ["🐴", "🐼", "🐶", "🐟", "🐖", "🐄", "🐰", "🦄", "🐭", "🐔"]   //emoji数组
    var indexGroup = [Int](repeating: 0, count: 3)  //随机数组
    
    // MARK: Override
    override func viewDidLoad() {
        super.viewDidLoad()
        // 初始化pickerView
        emojiPickerView.delegate = self
        emojiPickerView.dataSource = self
        emojiPickerView.selectRow(1, inComponent: 0, animated: false)
        emojiPickerView.selectRow(1, inComponent: 1, animated: false)
        emojiPickerView.selectRow(1, inComponent: 2, animated: false)
    }

    // MARK: Action
    /// 开始按钮事件
    @IBAction func playAction(_ sender: Any) {
        getRandomArray()
        // 重随pickerView
        self.emojiPickerView.selectRow(self.indexGroup[0], inComponent: 0, animated: true)
        self.emojiPickerView.selectRow(self.indexGroup[1], inComponent: 1, animated: true)
        self.emojiPickerView.selectRow(self.indexGroup[2], inComponent: 2, animated: true)
        // 按钮动画
        UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.1, initialSpringVelocity: 5, options: .curveLinear, animations: {
            self.playButton.bounds = CGRect(x: self.playButton.bounds.origin.x, y: self.playButton.bounds.origin.y, width: self.playButton.bounds.size.width - 20, height: self.playButton.bounds.size.height)
        }, completion: { (compelete: Bool) in
            UIView.animate(withDuration: 0.1, delay: 0.0, options: UIView.AnimationOptions(), animations: {
                self.playButton.bounds = CGRect(x: self.playButton.bounds.origin.x, y: self.playButton.bounds.origin.y, width: self.playButton.bounds.size.width, height: self.playButton.bounds.size.height)
            }, completion: nil)
        })
        resultLabel.text = compareEmoji(row1: indexGroup[0], row2: indexGroup[1], row3: indexGroup[2])
    }
    
    // MARK: Custom
    /// 获得随机数组
    private func getRandomArray() {
        for index in 0..<3 {
            indexGroup[index] = 1 + Int(arc4random_uniform(48))
        }
    }
    
    /// 比较emoji
    /// - parameter row1: 第一行行数
    /// - parameter row2: 第二行行数
    /// - parameter row3: 第三行行数
    /// - returns: String 结果字符串
    func compareEmoji(row1: Int, row2: Int, row3: Int) -> String {
        //print("\(row1)--\(row2)--\(row3)")
        if row1 % 10 == row2 % 10 {
            if row2 % 10 == row3 % 10 { return "👏👏👏" }
            else { return "💪💪💪" }
        } else {
            if row2 % 10 == row3 % 10 { return "💪💪💪" }
            else { return "💔💔💔" }
        }
    }

}

// MARK: Extension
extension ViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    /// 列数
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 3
    }
    
    /// 行数
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 50
    }
    
    /// 行高
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 100
    }
    
    /// 初始化每行
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let pickerLabel = UILabel()
        pickerLabel.text = emojiGroup[row % emojiGroup.count]
        pickerLabel.font = UIFont(name: "Apple Color Emoji", size: 70)
        pickerLabel.textAlignment = .center
        return pickerLabel
    }
}
