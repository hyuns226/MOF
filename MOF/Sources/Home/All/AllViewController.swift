//
//  AllViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/02/10.
//

import Foundation
import UIKit
import Kingfisher

class AllViewController : UIViewController{
    
    lazy var dataManager = HomeDataManager()
    
    var allResultList : [specificResults] = []
    
    @IBOutlet weak var mainViewHeight: NSLayoutConstraint!
    @IBOutlet weak var AllTableView: UITableView!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        print("home 필터 여부 : \(HomeViewController.isFiltered)")
        print("home 필터 지역 : \(HomeViewController.filterRegion)")
        
        if HomeViewController.isFiltered{
            
            dataManager.getSpecificAcademy(address: HomeViewController.filterRegion, genre: "", name: "", delegate: self)
            
        }else{
            dataManager.getSpecificAcademy(address: "", genre: "", name: "", delegate: self)
        }
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        AllTableView.dataSource = self
        AllTableView.delegate = self
        
    }
    
    
//MARK:- FUNCTION
    

}

extension AllViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
       
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AllTableViewCell") as! AllTableViewCell
        cell.separatorInset = UIEdgeInsets.zero
        cell.layer.cornerRadius = 12
        
        
        if let url = URL(string: allResultList[indexPath.section].academyBackImgUrl ?? "") {
            cell.AcademyImageView.kf.setImage(with: url)
        } else {
            cell.AcademyImageView.image = UIImage(named: "defaultImage")
        }
        
        cell.AcademyName.text = allResultList[indexPath.section].academyName
        cell.addressLabel.text = allResultList[indexPath.section].academyDetailAddress
        cell.PhoneNumLabel.text = allResultList[indexPath.section].academyPhone
        
        
       
       
        return cell
    }
    
    // MARK: - Table View delegate methods

        func numberOfSections(in tableView: UITableView) -> Int {
            return allResultList.count
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "AcademyDetaliViewController")as!AcademyDetaliViewController
        detailVC.AcademyInfo = detailAcademyInfo(academyIdx: allResultList[indexPath.section].academyIdx, academyImage: allResultList[indexPath.section].academyBackImgUrl, academyName: allResultList[indexPath.section].academyName, academyPhoneNum: allResultList[indexPath.section].academyPhone, academyAddress: allResultList[indexPath.section].academyDetailAddress)
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }

    
}


//MARK:- API
extension AllViewController{
    
    
    func failedToRequest(){
        
        self.presentAlert(title: "서버와의 연결이 원활하지 않습니다")
    
    }
    
}


extension AllViewController : specificAcademyProtocol{
    func specificAcademy(result: specificGenreResponse) {
        if result.isSuccess{
            print(result)
            allResultList = result.result ?? []
            AllTableView.reloadData()
            mainViewHeight.constant = AllTableView.contentSize.height
        }else{
            presentAlert(title: result.message)
        }
    }
    
    
}

