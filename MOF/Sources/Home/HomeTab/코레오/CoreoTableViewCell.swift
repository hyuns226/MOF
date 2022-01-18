//
//  CoreoTableViewCell.swift
//  MOF
//
//  Created by 이현서 on 2022/01/05.
//

import UIKit

class CoreoTableViewCell: UITableViewCell {

    @IBOutlet weak var AcademyImageView: UIImageView!
    @IBOutlet weak var AcademyName: UILabel!
    @IBOutlet weak var PhoneNumLabel: UILabel!
    @IBOutlet weak var AddLabel: NSLayoutConstraint!
    @IBOutlet weak var heartButton: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
