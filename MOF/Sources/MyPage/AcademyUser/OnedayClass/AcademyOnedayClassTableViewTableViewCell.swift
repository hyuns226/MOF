//
//  onedayClassTableViewTableViewCell.swift
//  MOF
//
//  Created by 이현서 on 2022/02/13.
//

import UIKit

class AcademyOnedayClassTableViewTableViewCell: UITableViewCell {

    
    @IBOutlet weak var academyNameLabel: UILabel!
    @IBOutlet weak var teacherNameLabel: UILabel!
    @IBOutlet weak var timeOneLabel: UILabel!
    @IBOutlet weak var timeTwoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.layer.cornerRadius = 19
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        if selected {
            contentView.backgroundColor = #colorLiteral(red: 0.8198420405, green: 0.819316566, blue: 0.8392156863, alpha: 0.5976322853)
            
            
        } else {
            contentView.backgroundColor = UIColor(hex: 0xF1F1F1)
            
        }
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
            super.setHighlighted(highlighted, animated: animated)
        if highlighted{
            contentView.backgroundColor = #colorLiteral(red: 0.8198420405, green: 0.819316566, blue: 0.8392156863, alpha: 0.5976322853)
    }else{
            contentView.backgroundColor = UIColor(hex: 0xF1F1F1)
            
        }
        }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 23, bottom:0 , right: 23))
    }

}
