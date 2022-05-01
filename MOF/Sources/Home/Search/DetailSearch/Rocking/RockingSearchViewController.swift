//
//  Rocking.swift
//  MOF
//
//  Created by 이현서 on 2022/04/13.
//

import UIKit
class RockingSearchViewController : UIViewController{
    
    var rockingResultList : [specificResults] = []
    lazy var dataManager = HomeDataManager()
    
    @IBOutlet weak var mainViewHeight: NSLayoutConstraint!

    @IBOutlet weak var RockingTableView: UITableView!
    
    @IBOutlet weak var emptyView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        NotificationCenter.default.addObserver(self, selector: #selector(self.refresh), name: NSNotification.Name(rawValue: "7"), object: nil)
        
        RockingTableView.dataSource = self
        RockingTableView.delegate = self
        if #available(iOS 15.0, *) {
            RockingTableView.sectionHeaderTopPadding = 0
        }
    }
    
    @objc func refresh() {
      
        print("searchword\(DetailSearchViewController.searchWord)")
        dataManager.getSpecificAcademy(address: DetailSearchViewController.filterRegion, genre: Constant.GenreList[6], name: DetailSearchViewController.searchWord, delegate: self)
     
        
    }
   
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        if DetailSearchViewController.isFiltered||DetailSearchViewController.searchWord != ""{
            
            dataManager.getSpecificAcademy(address: DetailSearchViewController.filterRegion, genre: Constant.GenreList[6], name: DetailSearchViewController.searchWord, delegate: self)
            
        }
    }
    
}

//MARK: - EXTENSION
extension RockingSearchViewController : UITableViewDataSource, UITableViewDelegate{
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
        cell.addressLabel.text = rockingResultList[indexPath.section].academyDetailAddress + " " + (rockingResultList[indexPath.section].academyBuilding ?? "")
        cell.PhoneNumLabel.text = rockingResultList[indexPath.section].academyPhone.hyphen()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "AcademyDetaliViewController")as!AcademyDetaliViewController
        detailVC.AcademyInfo = detailAcademyInfo(academyIdx: rockingResultList[indexPath.section].academyIdx, academyImage: rockingResultList[indexPath.section].academyBackImgUrl, academyName: rockingResultList[indexPath.section].academyName, academyPhoneNum: rockingResultList[indexPath.section].academyPhone, academyAddress: rockingResultList[indexPath.section].academyDetailAddress + " " + (rockingResultList[indexPath.section].academyBuilding ?? ""))
        
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

extension RockingSearchViewController : specificAcademyProtocol{
    func specificAcademy(result: specificGenreResponse) {
        if result.isSuccess{
            print(result)
            rockingResultList = result.result ?? []
            if rockingResultList.count == 0{
                emptyView.isHidden = false
            }else{
                RockingTableView.reloadData()
                mainViewHeight.constant = RockingTableView.contentSize.height
            }
            
        }else{
            presentAlert(title: result.message)
        }
    }
    func failedToRequest(){
        
        self.presentAlert(title: "서버와의 연결이 원활하지 않습니다")
    
    }
    
}


