//
//  ShoesViewController.swift
//  MOF
//
//  Created by 이현서 on 2021/10/26.
//

import UIKit
class CoreoViewController : UIViewController{
    
    static var choreoResultList : [specificResults] = []
    
    @IBOutlet weak var CoreoTableViewController: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CoreoTableViewController.delegate = self
        CoreoTableViewController.dataSource = self
        
    }
    
}


//MARK: - EXTENSION
extension CoreoViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoreoTableViewCell")as! CoreoTableViewCell
        cell.layer.cornerRadius = 12
        
        if let url = URL(string: CoreoViewController.choreoResultList[indexPath.section].academyBackImgUrl ?? "") {
            cell.AcademyImageView.kf.setImage(with: url)
        } else {
            cell.AcademyImageView.image = UIImage(named: "defaultImage")
        }
        
        cell.AcademyName.text = CoreoViewController.choreoResultList[indexPath.section].academyName
        cell.addressLabel.text = CoreoViewController.choreoResultList[indexPath.section].academyDetailAddress
        cell.PhoneNumLabel.text = CoreoViewController.choreoResultList[indexPath.section].academyPhone
        
        return cell
    }
    
    // MARK: - Table View delegate methods

        func numberOfSections(in tableView: UITableView) -> Int {
            return CoreoViewController.choreoResultList.count
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

