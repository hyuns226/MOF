//
//  RegularClassTableViewCell.swift
//  MOF
//
//  Created by 이현서 on 2021/12/02.
//

import UIKit

class MYRegularClassTableViewCell: UITableViewCell {

    
    @IBOutlet weak var academyNameLabel: UILabel!
    @IBOutlet weak var teacherNameLabel: UILabel!
    @IBOutlet weak var timeOneLabel: UILabel!
    @IBOutlet weak var timeTwoLabel: UILabel!
    

    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
