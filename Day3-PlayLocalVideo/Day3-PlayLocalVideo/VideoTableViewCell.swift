//
//  VideoTableViewCell.swift
//  Day3-PlayLocalVideo
//
//  Created by 田逸昕 on 2020/1/13.
//  Copyright © 2020 田逸昕. All rights reserved.
//

import UIKit

class VideoTableViewCell: UITableViewCell {

    @IBOutlet weak var videoImage: UIImageView! //视频缩略图
    @IBOutlet weak var nameLabel: UILabel!  //视频名
    @IBOutlet weak var durationLabel: UILabel!  //视频时长
    @IBOutlet weak var playButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
