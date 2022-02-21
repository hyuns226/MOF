//
//  RegularClassTableViewCell.swift
//  MOF
//
//  Created by 이현서 on 2021/11/16.
//

import UIKit

class RegularClassTableViewCell: UITableViewCell {

    @IBOutlet weak var classNameLabel: UILabel!
    @IBOutlet weak var teacherNameLabel: UILabel!
    @IBOutlet weak var classTimeOneLabel: UILabel!
    @IBOutlet weak var classTimeTwoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
