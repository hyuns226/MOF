//
//  ShoesViewController.swift
//  MOF
//
//  Created by 이현서 on 2021/10/26.
//

import UIKit
class CoreoViewController : UIViewController{
    
    var choreoResultList : [specificResults] = []
    lazy var dataManager = HomeDataManager()
    
    @IBOutlet weak var mainViewHeight: NSLayoutConstraint!
    @IBOutlet weak var CoreoTableView: UITableView!
    
    @IBOutlet weak var emptyView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CoreoTableView.delegate = self
        CoreoTableView.dataSource = self
        
        if #available(iOS 15.0, *) {
            CoreoTableView.sectionHeaderTopPadding = 0
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        if HomeViewController.isFiltered{
            
            dataManager.getSpecificAcademy(address: HomeViewController.filterRegion, genre: Constant.GenreList[1], name: "", delegate: self)
            
        }else{
            dataManager.getSpecificAcademy(address: "", genre: Constant.GenreList[1], name: "", delegate: self)
        }
        
    }
    
}


//MARK: - EXTENSION
extension CoreoViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoreoTableViewCell")as! CoreoTableViewCell
        cell.layer.cornerRadius = 12
        
        if let url = URL(string:choreoResultList[indexPath.section].academyBackImgUrl ?? "") {
            cell.AcademyImageView.kf.setImage(with: url)
        } else {
            cell.AcademyImageView.image = UIImage(named: "defaultImage")
        }
        
        cell.AcademyName.text = choreoResultList[indexPath.section].academyName
        cell.addressLabel.text = choreoResultList[indexPath.section].academyDetailAddress + " " + (choreoResultList[indexPath.section].academyBuilding ?? "")
        cell.PhoneNumLabel.text = choreoResultList[indexPath.section].academyPhone.hyphen()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "AcademyDetaliViewController")as!AcademyDetaliViewController
        detailVC.AcademyInfo = detailAcademyInfo(academyIdx: choreoResultList[indexPath.section].academyIdx, academyImage: choreoResultList[indexPath.section].academyBackImgUrl, academyName: choreoResultList[indexPath.section].academyName, academyPhoneNum: choreoResultList[indexPath.section].academyPhone, academyAddress: choreoResultList[indexPath.section].academyDetailAddress + " " + (choreoResultList[indexPath.section].academyBuilding ?? ""))
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // MARK: - Table View delegate methods

        func numberOfSections(in tableView: UITableView) -> Int {
            return choreoResultList.count
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

extension CoreoViewController : specificAcademyProtocol{
    func specificAcademy(result: specificGenreResponse) {
        if result.isSuccess{
            print(result)
            choreoResultList = result.result ?? []
            if choreoResultList.count == 0{
                emptyView.isHidden = false
            }else{
                CoreoTableView.reloadData()
                mainViewHeight.constant = CoreoTableView.contentSize.height
            }
            
        }else{
            presentAlert(title: result.message)
        }
    }
    
    func failedToRequest(){
        
        self.presentAlert(title: "서버와의 연결이 원활하지 않습니다")
    
    }
    
    
}


