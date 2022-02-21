//
//  HouseViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/01/05.
//

import UIKit
class HouseViewController : UIViewController{
    static var houseResultList : [specificResults] = []
    
    @IBOutlet weak var HouseTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HouseTableView.dataSource = self
        HouseTableView.delegate = self
    }
    
}

//MARK:- EXTENSION
extension HouseViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HouseTableViewCell")as!HouseTableViewCell
        cell.layer.cornerRadius = 12
        
        if let url = URL(string: HouseViewController.houseResultList[indexPath.section].academyBackImgUrl ?? "") {
            cell.AcademyImageView.kf.setImage(with: url)
        } else {
            cell.AcademyImageView.image = UIImage(named: "defaultImage")
        }
        
        cell.AcademyName.text = HouseViewController.houseResultList[indexPath.section].academyName
        cell.addressLabel.text = HouseViewController.houseResultList[indexPath.section].academyDetailAddress
        cell.PhoneNumLabel.text = HouseViewController.houseResultList[indexPath.section].academyPhone
        
        return cell
    }
    
    // MARK: - Table View delegate methods

        func numberOfSections(in tableView: UITableView) -> Int {
            return HouseViewController.houseResultList.count
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
