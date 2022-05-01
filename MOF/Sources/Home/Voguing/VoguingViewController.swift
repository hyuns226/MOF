//
//  VoguingViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/01/05.
//

import UIKit
class VoguingViewController : UIViewController{
    
    var voguingResultList : [specificResults] = []
    lazy var dataManager = HomeDataManager()
    
    @IBOutlet weak var mainViewHeight: NSLayoutConstraint!
    @IBOutlet weak var VoguingTableView: UITableView!
    
    @IBOutlet weak var emptyView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        VoguingTableView.dataSource = self
        VoguingTableView.delegate = self
        if #available(iOS 15.0, *) {
            VoguingTableView.sectionHeaderTopPadding = 0
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        if HomeViewController.isFiltered{
            
            dataManager.getSpecificAcademy(address: HomeViewController.filterRegion, genre: Constant.GenreList[8], name: "", delegate: self)
            
        }else{
            dataManager.getSpecificAcademy(address: "", genre: Constant.GenreList[8], name: "", delegate: self)
        }
    }
}

//MARK: - EXTENSION
extension VoguingViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VoguingTableViewCell")as!VoguingTableViewCell
        cell.layer.cornerRadius = 12
                if let url = URL(string: voguingResultList[indexPath.section].academyBackImgUrl ?? "") {
            cell.AcademyImageView.kf.setImage(with: url)
        } else {
            cell.AcademyImageView.image = UIImage(named: "defaultImage")
        }
        
        cell.AcademyName.text = voguingResultList[indexPath.section].academyName
        cell.addressLabel.text = voguingResultList[indexPath.section].academyDetailAddress + " " + (voguingResultList[indexPath.section].academyBuilding ?? "")
        cell.PhoneNumLabel.text = voguingResultList[indexPath.section].academyPhone.hyphen()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "AcademyDetaliViewController")as!AcademyDetaliViewController
        detailVC.AcademyInfo = detailAcademyInfo(academyIdx: voguingResultList[indexPath.section].academyIdx, academyImage: voguingResultList[indexPath.section].academyBackImgUrl, academyName: voguingResultList[indexPath.section].academyName, academyPhoneNum: voguingResultList[indexPath.section].academyPhone, academyAddress: voguingResultList[indexPath.section].academyDetailAddress + " " + (voguingResultList[indexPath.section].academyBuilding ?? ""))
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // MARK: - Table View delegate methods

        func numberOfSections(in tableView: UITableView) -> Int {
            return voguingResultList.count
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

extension VoguingViewController : specificAcademyProtocol{
    func specificAcademy(result: specificGenreResponse) {
        if result.isSuccess{
            print(result)
            voguingResultList = result.result ?? []
            if voguingResultList.count == 0{
                emptyView.isHidden = false
            }else{
                VoguingTableView.reloadData()
                mainViewHeight.constant = VoguingTableView.contentSize.height
            }
            
        }else{
            presentAlert(title: result.message)
        }
    }
    func failedToRequest(){
        
        self.presentAlert(title: "서버와의 연결이 원활하지 않습니다")
    
    }
    
}

