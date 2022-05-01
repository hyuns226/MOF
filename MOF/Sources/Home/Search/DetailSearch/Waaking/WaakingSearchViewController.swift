//
//  WaakingSearchViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/04/13.
//
import UIKit
class WaakingSearchViewController : UIViewController{
    
    var waakingResultList : [specificResults] = []
    lazy var dataManager = HomeDataManager()
    
    @IBOutlet weak var mainViewHeight: NSLayoutConstraint!
    @IBOutlet weak var WaakingTableView: UITableView!
    
    @IBOutlet weak var emptyView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.refresh), name: NSNotification.Name(rawValue: "5"), object: nil)
        
        WaakingTableView.dataSource = self
        WaakingTableView.delegate = self
        if #available(iOS 15.0, *) {
            WaakingTableView.sectionHeaderTopPadding = 0
        }
    }
    
    @objc func refresh() {
      
        print("searchword\(DetailSearchViewController.searchWord)")
        dataManager.getSpecificAcademy(address: DetailSearchViewController.filterRegion, genre: Constant.GenreList[4], name: DetailSearchViewController.searchWord, delegate: self)
     
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        if DetailSearchViewController.isFiltered||DetailSearchViewController.searchWord != ""{
            
            dataManager.getSpecificAcademy(address: DetailSearchViewController.filterRegion, genre: Constant.GenreList[4], name: DetailSearchViewController.searchWord, delegate: self)
            
        }
        
    }
    
}

//MARK :- EXTESNSION
extension WaakingSearchViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WaakingTableViewCell")as!WaakingTableViewCell
        cell.layer.cornerRadius = 12
        
        if let url = URL(string: waakingResultList[indexPath.section].academyBackImgUrl ?? "") {
            cell.AcademyImageView.kf.setImage(with: url)
        } else {
            cell.AcademyImageView.image = UIImage(named: "defaultImage")
        }
        
        cell.AcademyName.text = waakingResultList[indexPath.section].academyName
        cell.addressLabel.text = waakingResultList[indexPath.section].academyDetailAddress + " " + (waakingResultList[indexPath.section].academyBuilding ?? "")
        cell.PhoneNumLabel.text = waakingResultList[indexPath.section].academyPhone.hyphen()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "AcademyDetaliViewController")as!AcademyDetaliViewController
        detailVC.AcademyInfo = detailAcademyInfo(academyIdx: waakingResultList[indexPath.section].academyIdx, academyImage: waakingResultList[indexPath.section].academyBackImgUrl, academyName: waakingResultList[indexPath.section].academyName, academyPhoneNum: waakingResultList[indexPath.section].academyPhone, academyAddress: waakingResultList[indexPath.section].academyDetailAddress + " " + (waakingResultList[indexPath.section].academyBuilding ?? ""))
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
    // MARK: - Table View delegate methods

        func numberOfSections(in tableView: UITableView) -> Int {
            return waakingResultList.count
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

extension WaakingSearchViewController : specificAcademyProtocol{
    func specificAcademy(result: specificGenreResponse) {
        if result.isSuccess{
            print(result)
            waakingResultList = result.result ?? []
            if waakingResultList.count == 0{
                emptyView.isHidden = false
            }else{
                WaakingTableView.reloadData()
                mainViewHeight.constant = WaakingTableView.contentSize.height
            }
            
        }else{
            presentAlert(title: result.message)
        }
    }
    
    func failedToRequest(){
        
        self.presentAlert(title: "서버와의 연결이 원활하지 않습니다")
    
    }
}



