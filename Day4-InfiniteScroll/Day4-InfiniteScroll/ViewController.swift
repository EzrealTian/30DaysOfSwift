//
//  ViewController.swift
//  Day4-InfiniteScroll
//
//  Created by 田逸昕 on 2020/1/14.
//  Copyright © 2020 田逸昕. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    
    var leftView: UIImageView?  //左视图
    var centerView: UIImageView?    //中间视图
    var rightView: UIImageView? //右视图
    
    var picIndex = 1    //当前图片序号
    var pictureGroup = ["left", "center", "right"]  //图片数组
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scrollView.delegate = self  //设置滚动视图代理
        //获取视图宽高
        let width = self.view.frame.width
        let height = self.view.frame.height
        //初始滚动左视图
        leftView = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        leftView!.image = UIImage(named: "left")
        //初始滚动中视图
        centerView = UIImageView(frame: CGRect(x: width, y: 0, width: width, height: height))
        centerView!.image = UIImage(named: "center")
        //初始滚动右视图
        rightView = UIImageView(frame: CGRect(x: width * 2, y: 0, width: width, height: height))
        rightView!.image = UIImage(named: "right")
        //添加进主视图
        self.scrollView.addSubview(leftView!)
        self.scrollView.addSubview(centerView!)
        self.scrollView.addSubview(rightView!)
        self.scrollView.contentSize = CGSize(width: width * 3, height: height)
        self.scrollView.contentOffset.x = self.view.frame.width //设置滚动视图初始偏移
    }
    
    func changePage(offsetX: CGFloat) {
        let preOffsetX = self.view.frame.width //中间页的偏移量
        if offsetX > preOffsetX {   //向右滑动且距离够
            picIndex += 1   //右滑递增
        } else if offsetX < preOffsetX{    //向左滑动且距离够
            picIndex += 5   //左滑递减可能会为负，+5取模等价于-1
        }
        //刷新视图
        leftView?.image = UIImage(named: pictureGroup[(picIndex - 1) % 3])
        centerView?.image = UIImage(named: pictureGroup[picIndex % 3])
        rightView?.image = UIImage(named: pictureGroup[(picIndex + 1) % 3])
        //更新当前偏移量
        scrollView.contentOffset.x = preOffsetX
    }

}

extension ViewController: UIScrollViewDelegate {
    
    /// 滚动视图结束滚动时调用
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        changePage(offsetX: scrollView.contentOffset.x)
    }
}

