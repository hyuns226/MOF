//
//  VoguingViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/01/05.
//

import UIKit
class VoguingViewController : UIViewController{
    static var voguingResultList : [specificResults] = []
    
    @IBOutlet weak var VoguingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        VoguingTableView.dataSource = self
        VoguingTableView.delegate = self
    }
}

//MARK: - EXTENSION
extension VoguingViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VoguingTableViewCell")as!VoguingTableViewCell
        cell.layer.cornerRadius = 12
        
        if let url = URL(string: VoguingViewController.voguingResultList[indexPath.section].academyBackImgUrl ?? "") {
            cell.AcademyImageView.kf.setImage(with: url)
        } else {
            cell.AcademyImageView.image = UIImage(named: "defaultImage")
        }
        
        cell.AcademyName.text = VoguingViewController.voguingResultList[indexPath.section].academyName
        cell.addressLabel.text = VoguingViewController.voguingResultList[indexPath.section].academyDetailAddress
        cell.PhoneNumLabel.text = VoguingViewController.voguingResultList[indexPath.section].academyPhone
        
        return cell
    }
    
    // MARK: - Table View delegate methods

        func numberOfSections(in tableView: UITableView) -> Int {
            return VoguingViewController.voguingResultList.count
        }

        
        // Set the spacing between sections
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 15
        }

        // Make the background color show through
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
            headerView.backgroundColor = UIColor.clear
            return headerView
        }
    
    
    
    
    
}
