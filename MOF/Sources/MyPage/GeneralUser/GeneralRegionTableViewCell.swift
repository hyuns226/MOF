//
//  GeneralRegionTableView.swift
//  MOF
//
//  Created by 이현서 on 2022/01/12.
//

import UIKit

protocol GeneralRegionCellDelegate {
    func didPressButton(for index: Int,clicked: Bool)
}


class GeneralRegionTableViewCell: UITableViewCell {
    
    var delegate: GeneralRegionCellDelegate?
    var index: Int?
    
    @IBOutlet weak var regionButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    
    
    }
    @IBAction func didPressButton(_ sender: UIButton) {
            guard let idx = index else {return}
        if sender.isSelected == false {
                isTouched = true
                delegate?.didPressButton(for: idx, clicked: true)
            }else {
               isTouched = false
                delegate?.didPressButton(for: idx, clicked: false)
            }
         
        }
    
    var isTouched: Bool? {
            didSet {
                if isTouched == true {
                    
                 regionButton.setTitleColor(.mainPink, for: .normal)
                   print("클릭")
                
                }else{
                    
                    regionButton.setTitleColor(.black, for: .normal)
                 
                    print("안클릭")
                   
                }
            }
        }
    
    
    
}
