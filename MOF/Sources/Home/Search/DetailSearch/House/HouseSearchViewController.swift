//
//  HouseSearchViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/04/13.
//

import UIKit
class HouseSearchViewController : UIViewController{
    
    
    var houseResultList : [specificResults] = []
    lazy var dataManager = HomeDataManager()
    
    @IBOutlet weak var mainViewHeight: NSLayoutConstraint!
    @IBOutlet weak var HouseTableView: UITableView!
    
    @IBOutlet weak var emptyView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        NotificationCenter.default.addObserver(self, selector: #selector(self.refresh), name: NSNotification.Name(rawValue: "10"), object: nil)
        
        HouseTableView.dataSource = self
        HouseTableView.delegate = self
        if #available(iOS 15.0, *) {
            HouseTableView.sectionHeaderTopPadding = 0
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        if DetailSearchViewController.isFiltered||DetailSearchViewController.searchWord != ""{
            dataManager.getSpecificAcademy(address: DetailSearchViewController.filterRegion, genre: Constant.GenreList[9], name: DetailSearchViewController.searchWord, delegate: self)
            
        }
    }
    @objc func refresh() {
      
        print("searchword\(DetailSearchViewController.searchWord)")
        dataManager.getSpecificAcademy(address: DetailSearchViewController.filterRegion, genre: Constant.GenreList[9], name: DetailSearchViewController.searchWord, delegate: self)
     
        
    }
    
}

//MARK:- EXTENSION
extension HouseSearchViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HouseTableViewCell")as!HouseTableViewCell
        cell.layer.cornerRadius = 12
        
        if let url = URL(string: houseResultList[indexPath.section].academyBackImgUrl ?? "") {
            cell.AcademyImageView.kf.setImage(with: url)
        } else {
            cell.AcademyImageView.image = UIImage(named: "defaultImage")
        }
        
        cell.AcademyName.text = houseResultList[indexPath.section].academyName
        cell.addressLabel.text = houseResultList[indexPath.section].academyDetailAddress + " " + (houseResultList[indexPath.section].academyBuilding ?? "")
        cell.PhoneNumLabel.text = houseResultList[indexPath.section].academyPhone.hyphen()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "AcademyDetaliViewController")as!AcademyDetaliViewController
        detailVC.AcademyInfo = detailAcademyInfo(academyIdx: houseResultList[indexPath.section].academyIdx, academyImage: houseResultList[indexPath.section].academyBackImgUrl, academyName: houseResultList[indexPath.section].academyName, academyPhoneNum: houseResultList[indexPath.section].academyPhone, academyAddress: houseResultList[indexPath.section].academyDetailAddress + " " + (houseResultList[indexPath.section].academyBuilding ?? ""))
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // MARK: - Table View delegate methods

        func numberOfSections(in tableView: UITableView) -> Int {
            return houseResultList.count
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

extension HouseSearchViewController : specificAcademyProtocol{
    func specificAcademy(result: specificGenreResponse) {
        if result.isSuccess{
            print(result)
            houseResultList = result.result ?? []
            if houseResultList.count == 0{
                emptyView.isHidden = false
            }else{
                HouseTableView.reloadData()
                mainViewHeight.constant = HouseTableView.contentSize.height
            }
            
        }else{
            presentAlert(title: result.message)
        }
    }
    func failedToRequest(){
        
        self.presentAlert(title: "서버와의 연결이 원활하지 않습니다")
    
    }
    
}


