//
//  RockingViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/01/05.
//

import UIKit
class RockingViewController : UIViewController{
    
    var rockingResultList : [specificResults] = []
    lazy var dataManager = HomeDataManager()
    
    @IBOutlet weak var mainViewHeight: NSLayoutConstraint!
    @IBOutlet weak var RockingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RockingTableView.dataSource = self
        RockingTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        if HomeViewController.isFiltered{
            
            dataManager.getSpecificAcademy(address: HomeViewController.filterRegion, genre: Constant.GenreList[6], name: "", delegate: self)
            
        }else{
            dataManager.getSpecificAcademy(address: "", genre: Constant.GenreList[6], name: "", delegate: self)
        }
    }
    
}

//MARK: - EXTENSION
extension RockingViewController : UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView,cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RockingTableViewCell")as!RockingTableViewCell
        cell.layer.cornerRadius = 12
        
        if let url = URL(string: rockingResultList[indexPath.section].academyBackImgUrl ?? "") {
            cell.AcademyImageView.kf.setImage(with: url)
        } else {
            cell.AcademyImageView.image = UIImage(named: "defaultImage")
        }
        
        cell.AcademyName.text = rockingResultList[indexPath.section].academyName
        cell.addressLabel.text = rockingResultList[indexPath.section].academyDetailAddress
        cell.PhoneNumLabel.text = rockingResultList[indexPath.section].academyPhone
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "AcademyDetaliViewController")as!AcademyDetaliViewController
        detailVC.AcademyInfo = detailAcademyInfo(academyIdx: rockingResultList[indexPath.section].academyIdx, academyImage: rockingResultList[indexPath.section].academyBackImgUrl, academyName: rockingResultList[indexPath.section].academyName, academyPhoneNum: rockingResultList[indexPath.section].academyPhone, academyAddress: rockingResultList[indexPath.section].academyDetailAddress)
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // MARK: - Table View delegate methods

        func numberOfSections(in tableView: UITableView) -> Int {
            return rockingResultList.count
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

extension RockingViewController : specificAcademyProtocol{
    func specificAcademy(result: specificGenreResponse) {
        if result.isSuccess{
            print(result)
            rockingResultList = result.result ?? []
            RockingTableView.reloadData()
            mainViewHeight.constant = RockingTableView.contentSize.height
        }else{
            presentAlert(title: result.message)
        }
    }
    
    
}

