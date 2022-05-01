//
//  AllSearchViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/04/13.
//

import Foundation
import UIKit
import Kingfisher

class AllSearchViewController : UIViewController{
    
    lazy var dataManager = HomeDataManager()
    
    var allResultList : [specificResults] = []
    
    @IBOutlet weak var mainViewHeight: NSLayoutConstraint!
    
    
    @IBOutlet var AllTableView: UITableView!
    
    @IBOutlet weak var emptyView: UIView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        print("allviewWillAppear")
        
        print("home 필터 여부 : \(DetailSearchViewController.isFiltered)")
        print("home 필터 지역 : \(DetailSearchViewController.filterRegion)")
        
        if DetailSearchViewController.isFiltered||DetailSearchViewController.searchWord != ""{
            
            dataManager.getSpecificAcademy(address: DetailSearchViewController.filterRegion, genre: "", name: DetailSearchViewController.searchWord, delegate: self)
            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        DetailSearchViewController.isFiltered = false
        DetailSearchViewController.filterRegion = ""
        DetailSearchViewController.searchWord  = ""
        print("allviewloaded")
        AllTableView.dataSource = self
        AllTableView.delegate = self
       
        NotificationCenter.default.addObserver(self, selector: #selector(self.refresh), name: NSNotification.Name(rawValue: "0"), object: nil)
        if #available(iOS 15.0, *) {
            AllTableView.sectionHeaderTopPadding = 0
        }
        
    }
    
    @objc func refresh() {
      
        print("searchword\(DetailSearchViewController.searchWord)")
        dataManager.getSpecificAcademy(address: DetailSearchViewController.filterRegion, genre: "", name: DetailSearchViewController.searchWord, delegate: self)
     
        
    }
    
    
//MARK:- FUNCTION
    

}

extension AllSearchViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if allResultList.count == 0{
            emptyView.isHidden = false
            return 0
        }else{
            emptyView.isHidden = true
            return 1
        }
       
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
        cell.addressLabel.text = allResultList[indexPath.section].academyDetailAddress + " " + (allResultList[indexPath.section].academyBuilding ?? "")
        cell.PhoneNumLabel.text = allResultList[indexPath.section].academyPhone.hyphen()
        
        
       
       
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
        detailVC.AcademyInfo = detailAcademyInfo(academyIdx: allResultList[indexPath.section].academyIdx, academyImage: allResultList[indexPath.section].academyBackImgUrl, academyName: allResultList[indexPath.section].academyName, academyPhoneNum: allResultList[indexPath.section].academyPhone, academyAddress: allResultList[indexPath.section].academyDetailAddress + " " + (allResultList[indexPath.section].academyBuilding ?? ""))
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }

    
}


//MARK:- API
extension AllSearchViewController{
    
    
    func failedToRequest(){
        
        self.presentAlert(title: "서버와의 연결이 원활하지 않습니다")
    
    }
    
}


extension AllSearchViewController : specificAcademyProtocol{
    func specificAcademy(result: specificGenreResponse) {
        if result.isSuccess{
            print(result)
            allResultList = result.result ?? []
            if allResultList.count == 0{
                emptyView.isHidden = false
            }else{
                AllTableView.reloadData()
                mainViewHeight.constant = AllTableView.contentSize.height
            }
            
        }else{
            presentAlert(title: result.message)
        }
    }
    
    
    
    
}

