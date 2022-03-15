//
//  UpcyclingViewController.swift
//  MOF
//
//  Created by 이현서 on 2021/10/26.
//

import UIKit
class WaakingViewController : UIViewController{
    
    var waakingResultList : [specificResults] = []
    lazy var dataManager = HomeDataManager()
    
    @IBOutlet weak var mainViewHeight: NSLayoutConstraint!
    @IBOutlet weak var WaakingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WaakingTableView.dataSource = self
        WaakingTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        if HomeViewController.isFiltered{
            
            dataManager.getSpecificAcademy(address: HomeViewController.filterRegion, genre: Constant.GenreList[4], name: "", delegate: self)
            
        }else{
            dataManager.getSpecificAcademy(address: "", genre: Constant.GenreList[4], name: "", delegate: self)
        }
        
    }
    
}

//MARK :- EXTESNSION
extension WaakingViewController : UITableViewDelegate, UITableViewDataSource{
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
        cell.addressLabel.text = waakingResultList[indexPath.section].academyDetailAddress
        cell.PhoneNumLabel.text = waakingResultList[indexPath.section].academyPhone
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "AcademyDetaliViewController")as!AcademyDetaliViewController
        detailVC.AcademyInfo = detailAcademyInfo(academyIdx: waakingResultList[indexPath.section].academyIdx, academyImage: waakingResultList[indexPath.section].academyBackImgUrl, academyName: waakingResultList[indexPath.section].academyName, academyPhoneNum: waakingResultList[indexPath.section].academyPhone, academyAddress: waakingResultList[indexPath.section].academyDetailAddress)
        
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

extension WaakingViewController : specificAcademyProtocol{
    func specificAcademy(result: specificGenreResponse) {
        if result.isSuccess{
            print(result)
            waakingResultList = result.result ?? []
            WaakingTableView.reloadData()
            mainViewHeight.constant = WaakingTableView.contentSize.height
        }else{
            presentAlert(title: result.message)
        }
    }
    
    
}


