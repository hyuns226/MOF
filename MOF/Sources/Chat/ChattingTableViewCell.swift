//
//  ChattingTableViewCell.swift
//  MOF
//
//  Created by 이현서 on 2021/11/23.
//

import UIKit

class ChattingTableViewCell: UITableViewCell {
    @IBOutlet weak var ProfileImage: UIImageView!
    @IBOutlet weak var academyName: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var newView: UIView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var moreButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        ProfileImage.layer.cornerRadius  = 25
        newView.layer.cornerRadius = 3.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
