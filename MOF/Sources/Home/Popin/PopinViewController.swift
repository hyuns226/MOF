//
//  PopinViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/01/05.
//

import UIKit
class PopinViewController : UIViewController{
    
    var popinResultList : [specificResults] = []
    lazy var dataManager = HomeDataManager()
    
    @IBOutlet weak var mainViewHeight: NSLayoutConstraint!
    @IBOutlet weak var PopinTableView: UITableView!
    
    @IBOutlet weak var emptyView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PopinTableView.delegate = self
        PopinTableView.dataSource = self
        if #available(iOS 15.0, *) {
            PopinTableView.sectionHeaderTopPadding = 0
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        if HomeViewController.isFiltered{
            
            dataManager.getSpecificAcademy(address: HomeViewController.filterRegion, genre: Constant.GenreList[5], name: "", delegate: self)
            
        }else{
            dataManager.getSpecificAcademy(address: "", genre: Constant.GenreList[5], name: "", delegate: self)
        }
    }

}

//MARK:- EXTENSION
extension PopinViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PopinTableViewCell")as!PopinTableViewCell
        cell.layer.cornerRadius = 12
        
        if let url = URL(string: popinResultList[indexPath.section].academyBackImgUrl ?? "") {
            cell.AcademyImageView.kf.setImage(with: url)
        } else {
            cell.AcademyImageView.image = UIImage(named: "defaultImage")
        }
        
        cell.AcademyName.text = popinResultList[indexPath.section].academyName
        cell.addressLabel.text = popinResultList[indexPath.section].academyDetailAddress + " " + (popinResultList[indexPath.section].academyBuilding ?? "")
        cell.PhoneNumLabel.text = popinResultList[indexPath.section].academyPhone.hyphen()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "AcademyDetaliViewController")as!AcademyDetaliViewController
        detailVC.AcademyInfo = detailAcademyInfo(academyIdx: popinResultList[indexPath.section].academyIdx, academyImage: popinResultList[indexPath.section].academyBackImgUrl, academyName: popinResultList[indexPath.section].academyName, academyPhoneNum: popinResultList[indexPath.section].academyPhone, academyAddress: popinResultList[indexPath.section].academyDetailAddress + " " + (popinResultList[indexPath.section].academyBuilding ?? ""))
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // MARK: - Table View delegate methods

        func numberOfSections(in tableView: UITableView) -> Int {
            return popinResultList.count
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

extension PopinViewController : specificAcademyProtocol{
    func specificAcademy(result: specificGenreResponse) {
        if result.isSuccess{
            print(result)
            popinResultList = result.result ?? []
            if popinResultList.count == 0{
                emptyView.isHidden = false
            }else{
                PopinTableView.reloadData()
                mainViewHeight.constant = PopinTableView.contentSize.height
            }
            
        }else{
            presentAlert(title: result.message)
        }
    }
    
    func failedToRequest(){
        
        self.presentAlert(title: "서버와의 연결이 원활하지 않습니다")
    
    }
    
    
}

