//
//  GirlsHiphopSearchViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/04/13.
//

import UIKit
class GirlsHiphopSearchViewController : UIViewController{
    
    var girlsHiphopResultList : [specificResults] = []
    lazy var dataManager = HomeDataManager()
    
    @IBOutlet weak var mainViewHeight: NSLayoutConstraint!
    @IBOutlet weak var GirlsHiphopTableView: UITableView!
    
    @IBOutlet weak var emptyView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        NotificationCenter.default.addObserver(self, selector: #selector(self.refresh), name: NSNotification.Name(rawValue: "4"), object: nil)
        
        GirlsHiphopTableView.delegate = self
        GirlsHiphopTableView.dataSource = self
        
        if #available(iOS 15.0, *) {
            GirlsHiphopTableView.sectionHeaderTopPadding = 0
        }
    }
    
    @objc func refresh() {
      
        print("searchword\(DetailSearchViewController.searchWord)")
        dataManager.getSpecificAcademy(address: DetailSearchViewController.filterRegion, genre: Constant.GenreList[3], name: DetailSearchViewController.searchWord, delegate: self)
     
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        if DetailSearchViewController.isFiltered||DetailSearchViewController.searchWord != ""{
            
            dataManager.getSpecificAcademy(address: DetailSearchViewController.filterRegion, genre: Constant.GenreList[3], name: DetailSearchViewController.searchWord, delegate: self)
            
        }
    }
    
}

//MARK: - EXTENSION
extension GirlsHiphopSearchViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GirlsHiphopTableViewCell") as! GirlsHiphopTableViewCell
        
        cell.layer.cornerRadius = 12
        
        if let url = URL(string: girlsHiphopResultList[indexPath.section].academyBackImgUrl ?? "") {
            cell.AcademyImageView.kf.setImage(with: url)
        } else {
            cell.AcademyImageView.image = UIImage(named: "defaultImage")
        }
        
        cell.AcademyName.text = girlsHiphopResultList[indexPath.section].academyName
        cell.addressLabel.text = girlsHiphopResultList[indexPath.section].academyDetailAddress + " " + (girlsHiphopResultList[indexPath.section].academyBuilding ?? "")
        cell.PhoneNumLabel.text = girlsHiphopResultList[indexPath.section].academyPhone.hyphen()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "AcademyDetaliViewController")as!AcademyDetaliViewController
        detailVC.AcademyInfo = detailAcademyInfo(academyIdx: girlsHiphopResultList[indexPath.section].academyIdx, academyImage: girlsHiphopResultList[indexPath.section].academyBackImgUrl, academyName: girlsHiphopResultList[indexPath.section].academyName, academyPhoneNum: girlsHiphopResultList[indexPath.section].academyPhone, academyAddress: girlsHiphopResultList[indexPath.section].academyDetailAddress + " " + (girlsHiphopResultList[indexPath.section].academyBuilding ?? ""))
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // MARK: - Table View delegate methods

        func numberOfSections(in tableView: UITableView) -> Int {
            return girlsHiphopResultList.count
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

extension GirlsHiphopSearchViewController : specificAcademyProtocol{
    func specificAcademy(result: specificGenreResponse) {
        if result.isSuccess{
            print(result)
            girlsHiphopResultList = result.result ?? []
            if girlsHiphopResultList.count == 0{
                emptyView.isHidden = false
            }else{
                GirlsHiphopTableView.reloadData()
                mainViewHeight.constant = GirlsHiphopTableView.contentSize.height
            }
            
        }else{
            presentAlert(title: result.message)
        }
    }
    
    func failedToRequest(){
        
        self.presentAlert(title: "서버와의 연결이 원활하지 않습니다")
    
    }
    
}



