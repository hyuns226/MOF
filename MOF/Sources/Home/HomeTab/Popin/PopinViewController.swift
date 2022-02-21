//
//  PopinViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/01/05.
//

import UIKit
class PopinViewController : UIViewController{
    static var popinResultList : [specificResults] = []
    
    @IBOutlet weak var PopinTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PopinTableView.delegate = self
        PopinTableView.dataSource = self
    }

}

//MARK:- EXTENSION
extension PopinViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PopinTableViewCell")as!PopinTableViewCell
        cell.layer.cornerRadius = 12
        
        if let url = URL(string: PopinViewController.popinResultList[indexPath.section].academyBackImgUrl ?? "") {
            cell.AcademyImageView.kf.setImage(with: url)
        } else {
            cell.AcademyImageView.image = UIImage(named: "defaultImage")
        }
        
        cell.AcademyName.text = PopinViewController.popinResultList[indexPath.section].academyName
        cell.addressLabel.text = PopinViewController.popinResultList[indexPath.section].academyDetailAddress
        cell.PhoneNumLabel.text = PopinViewController.popinResultList[indexPath.section].academyPhone
        
        return cell
    }
    
    // MARK: - Table View delegate methods

        func numberOfSections(in tableView: UITableView) -> Int {
            return PopinViewController.popinResultList.count
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
