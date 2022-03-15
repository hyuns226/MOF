//
//  EnrollListTableViewCell.swift
//  MOF
//
//  Created by 이현서 on 2022/03/12.
//

import UIKit

class EnrollListTableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var phoneNumLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var enrolledTimeLabel: UILabel!
    @IBOutlet weak var approveButton: UIButton!
    @IBOutlet weak var refuseButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        approveButton.layer.cornerRadius = 15
        refuseButton.layer.cornerRadius = 15
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 23, bottom:0 , right: 23))
    }
}
