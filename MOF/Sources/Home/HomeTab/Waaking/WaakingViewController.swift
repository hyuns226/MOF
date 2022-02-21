//
//  UpcyclingViewController.swift
//  MOF
//
//  Created by 이현서 on 2021/10/26.
//

import UIKit
class WaakingViewController : UIViewController{
    static var waakingResultList : [specificResults] = []
    
    @IBOutlet weak var WaakingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WaakingTableView.dataSource = self
        WaakingTableView.delegate = self
    }
    
}

//MARK :- EXTESNSION
extension WaakingViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WaakingTableViewCell")as!WaakingTableViewCell
        cell.layer.cornerRadius = 12
        
        if let url = URL(string: WaakingViewController.waakingResultList[indexPath.section].academyBackImgUrl ?? "") {
            cell.AcademyImageView.kf.setImage(with: url)
        } else {
            cell.AcademyImageView.image = UIImage(named: "defaultImage")
        }
        
        cell.AcademyName.text = WaakingViewController.waakingResultList[indexPath.section].academyName
        cell.addressLabel.text = WaakingViewController.waakingResultList[indexPath.section].academyDetailAddress
        cell.PhoneNumLabel.text = WaakingViewController.waakingResultList[indexPath.section].academyPhone
        
        return cell
    }
    
    
    // MARK: - Table View delegate methods

        func numberOfSections(in tableView: UITableView) -> Int {
            return WaakingViewController.waakingResultList.count
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

