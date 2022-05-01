//
//  KPOPSearchViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/04/13.
//


import UIKit
class KpopSearchViewController : UIViewController{
    
    var kpopResultList : [specificResults] = []
    lazy var dataManager = HomeDataManager()
    
    @IBOutlet weak var mainViewHeight: NSLayoutConstraint!
    @IBOutlet weak var KpopTableView: UITableView!
    
    @IBOutlet weak var emptyView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        KpopTableView.dataSource = self
        KpopTableView.delegate = self
    
    
        NotificationCenter.default.addObserver(self, selector: #selector(self.refresh), name: NSNotification.Name(rawValue: "1"), object: nil)
        
        if #available(iOS 15.0, *) {
            KpopTableView.sectionHeaderTopPadding = 0
        }
        
    }
    @objc func refresh() {
      
        print("searchword\(DetailSearchViewController.searchWord)")
        dataManager.getSpecificAcademy(address: DetailSearchViewController.filterRegion, genre: Constant.GenreList[0], name: DetailSearchViewController.searchWord, delegate: self)

    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        if DetailSearchViewController.isFiltered||DetailSearchViewController.searchWord != ""{
            
            dataManager.getSpecificAcademy(address: DetailSearchViewController.filterRegion, genre: Constant.GenreList[0], name: DetailSearchViewController.searchWord, delegate: self)
            
        }
        
        
    }
    

     

}

extension KpopSearchViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "KpopTableViewCell") as! KpopTableViewCell
        cell.separatorInset = UIEdgeInsets.zero
        cell.layer.cornerRadius = 12
        
        if let url = URL(string: kpopResultList[indexPath.section].academyBackImgUrl ?? "") {
            cell.AcademyImageView.kf.setImage(with: url)
        } else {
            cell.AcademyImageView.image = UIImage(named: "defaultImage")
        }
        
        cell.AcademyName.text = kpopResultList[indexPath.section].academyName
        cell.addressLabel.text = kpopResultList[indexPath.section].academyDetailAddress + " " + (kpopResultList[indexPath.section].academyBuilding ?? "")
        cell.PhoneNumLabel.text = kpopResultList[indexPath.section].academyPhone.hyphen()
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "AcademyDetaliViewController")as!AcademyDetaliViewController
        detailVC.AcademyInfo = detailAcademyInfo(academyIdx: kpopResultList[indexPath.section].academyIdx, academyImage: kpopResultList[indexPath.section].academyBackImgUrl, academyName: kpopResultList[indexPath.section].academyName, academyPhoneNum: kpopResultList[indexPath.section].academyPhone, academyAddress: kpopResultList[indexPath.section].academyDetailAddress + " " + (kpopResultList[indexPath.section].academyBuilding ?? ""))
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // MARK: - Table View delegate methods

        func numberOfSections(in tableView: UITableView) -> Int {
            return kpopResultList.count
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

extension KpopSearchViewController : specificAcademyProtocol{
    func specificAcademy(result: specificGenreResponse) {
        if result.isSuccess{
            print(result)
            kpopResultList = result.result ?? []
            if kpopResultList.count == 0{
                emptyView.isHidden = false
            }else{
                KpopTableView.reloadData()
                mainViewHeight.constant = KpopTableView.contentSize.height
                emptyView.isHidden = true
            }
            
        }else{
            presentAlert(title: result.message)
        }
    }
    
    func failedToRequest(){
        
        self.presentAlert(title: "서버와의 연결이 원활하지 않습니다")
    
    }
}



