//
//  Crump.swift
//  MOF
//
//  Created by 이현서 on 2022/04/13.
//

import UIKit
class CrumpSearchViewController : UIViewController {
    
     var crumpResultList : [specificResults] = []
    lazy var dataManager = HomeDataManager()
    
    @IBOutlet weak var mainViewHeight: NSLayoutConstraint!
    @IBOutlet weak var CrumpTableView: UITableView!
    
    @IBOutlet weak var emptyView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        NotificationCenter.default.addObserver(self, selector: #selector(self.refresh), name: NSNotification.Name(rawValue: "8"), object: nil)
        
        CrumpTableView.delegate = self
        CrumpTableView.dataSource = self
        if #available(iOS 15.0, *) {
            CrumpTableView.sectionHeaderTopPadding = 0
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        if DetailSearchViewController.isFiltered||DetailSearchViewController.searchWord != ""{
            
            dataManager.getSpecificAcademy(address: DetailSearchViewController.filterRegion, genre: Constant.GenreList[7], name: DetailSearchViewController.searchWord, delegate: self)
            
        }
    }
    
    @objc func refresh() {
      
        print("searchword\(DetailSearchViewController.searchWord)")
        dataManager.getSpecificAcademy(address: DetailSearchViewController.filterRegion, genre: Constant.GenreList[7], name: DetailSearchViewController.searchWord, delegate: self)
     
        
    }
    
}

//MARK:- EXTENSION
extension CrumpSearchViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CrumpTableViewCell")as!CrumpTableViewCell
        cell.layer.cornerRadius = 12
        
        if let url = URL(string: crumpResultList[indexPath.section].academyBackImgUrl ?? "") {
            cell.AcademyImageView.kf.setImage(with: url)
        } else {
            cell.AcademyImageView.image = UIImage(named: "defaultImage")
        }
        
        cell.AcademyName.text = crumpResultList[indexPath.section].academyName
        cell.addressLabel.text = crumpResultList[indexPath.section].academyDetailAddress + " " + (crumpResultList[indexPath.section].academyBuilding ?? "")
        cell.PhoneNumLabel.text = crumpResultList[indexPath.section].academyPhone.hyphen()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "AcademyDetaliViewController")as!AcademyDetaliViewController
        detailVC.AcademyInfo = detailAcademyInfo(academyIdx: crumpResultList[indexPath.section].academyIdx, academyImage: crumpResultList[indexPath.section].academyBackImgUrl, academyName: crumpResultList[indexPath.section].academyName, academyPhoneNum: crumpResultList[indexPath.section].academyPhone, academyAddress: crumpResultList[indexPath.section].academyDetailAddress + " " + (crumpResultList[indexPath.section].academyBuilding ?? ""))
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // MARK: - Table View delegate methods

        func numberOfSections(in tableView: UITableView) -> Int {
            return crumpResultList.count
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

extension CrumpSearchViewController : specificAcademyProtocol{
    func specificAcademy(result: specificGenreResponse) {
        if result.isSuccess{
            print(result)
            crumpResultList = result.result ?? []
            if crumpResultList.count == 0{
                emptyView.isHidden = false
            }else{
                CrumpTableView.reloadData()
                mainViewHeight.constant = CrumpTableView.contentSize.height
            }
            
        }else{
            presentAlert(title: result.message)
        }
    }
    
    func failedToRequest(){
        
        self.presentAlert(title: "서버와의 연결이 원활하지 않습니다")
    
    }
}


