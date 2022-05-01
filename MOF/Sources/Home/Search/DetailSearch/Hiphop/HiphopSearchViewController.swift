//
//  HiphopSearchViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/04/13.
//
import UIKit
class HiphopSearchViewController : UIViewController{
    
    var hiphopResultList : [specificResults] = []
    lazy var dataManager = HomeDataManager()
    
    @IBOutlet weak var mainViewHeight: NSLayoutConstraint!
    @IBOutlet weak var HiphopTableView: UITableView!
    
    @IBOutlet weak var emptyView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.refresh), name: NSNotification.Name(rawValue: "3"), object: nil)
        HiphopTableView.dataSource = self
        HiphopTableView.delegate = self
        
        if #available(iOS 15.0, *) {
            HiphopTableView.sectionHeaderTopPadding = 0
        }
    }
    
    @objc func refresh() {
      
        print("searchword\(DetailSearchViewController.searchWord)")
       
        dataManager.getSpecificAcademy(address: DetailSearchViewController.filterRegion, genre: Constant.GenreList[2], name: DetailSearchViewController.searchWord, delegate: self)
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        if DetailSearchViewController.isFiltered||DetailSearchViewController.searchWord != ""{
            
            dataManager.getSpecificAcademy(address: DetailSearchViewController.filterRegion, genre: Constant.GenreList[2], name: DetailSearchViewController.searchWord, delegate: self)
            
        }
       
    
}
}

extension HiphopSearchViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HiphopTableViewCell") as! HiphopTableViewCell
        cell.layer.cornerRadius = 12
        
        if let url = URL(string: hiphopResultList[indexPath.section].academyBackImgUrl ?? "") {
            cell.AcademyImageView.kf.setImage(with: url)
        } else {
            cell.AcademyImageView.image = UIImage(named: "defaultImage")
        }
        
        cell.AcademyName.text = hiphopResultList[indexPath.section].academyName
        cell.addressLabel.text = hiphopResultList[indexPath.section].academyDetailAddress + " " + (hiphopResultList[indexPath.section].academyBuilding ?? "")
        cell.PhoneNumLabel.text = hiphopResultList[indexPath.section].academyPhone.hyphen()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "AcademyDetaliViewController")as!AcademyDetaliViewController
        detailVC.AcademyInfo = detailAcademyInfo(academyIdx: hiphopResultList[indexPath.section].academyIdx, academyImage: hiphopResultList[indexPath.section].academyBackImgUrl, academyName: hiphopResultList[indexPath.section].academyName, academyPhoneNum: hiphopResultList[indexPath.section].academyPhone, academyAddress: hiphopResultList[indexPath.section].academyDetailAddress + " " + (hiphopResultList[indexPath.section].academyBuilding ?? ""))
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // MARK: - Table View delegate methods

        func numberOfSections(in tableView: UITableView) -> Int {
            return hiphopResultList.count
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

extension HiphopSearchViewController : specificAcademyProtocol{
    func specificAcademy(result: specificGenreResponse) {
        if result.isSuccess{
            print(result)
            hiphopResultList = result.result ?? []
            if hiphopResultList.count == 0{
                emptyView.isHidden = false
            }else{
                HiphopTableView.reloadData()
                mainViewHeight.constant = HiphopTableView.contentSize.height
            }
            
        }else{
            presentAlert(title: result.message)
        }
    }
    
    func failedToRequest(){
        
        self.presentAlert(title: "서버와의 연결이 원활하지 않습니다")
    
    }
}


