//
//  ClothesViewController.swift
//  MOF
//
//  Created by 이현서 on 2021/10/26.
//

import UIKit
class HiphopViewController : UIViewController{
    
    var hiphopResultList : [specificResults] = []
    lazy var dataManager = HomeDataManager()
    
    @IBOutlet weak var mainViewHeight: NSLayoutConstraint!
    @IBOutlet weak var HiphopTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HiphopTableView.dataSource = self
        HiphopTableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        if HomeViewController.isFiltered{
            
            dataManager.getSpecificAcademy(address: HomeViewController.filterRegion, genre: Constant.GenreList[2], name: "", delegate: self)
            
        }else{
            dataManager.getSpecificAcademy(address: "", genre: Constant.GenreList[2], name: "", delegate: self)
        }
       
    
}
}

extension HiphopViewController : UITableViewDelegate, UITableViewDataSource{
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
        cell.addressLabel.text = hiphopResultList[indexPath.section].academyDetailAddress
        cell.PhoneNumLabel.text = hiphopResultList[indexPath.section].academyPhone
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "AcademyDetaliViewController")as!AcademyDetaliViewController
        detailVC.AcademyInfo = detailAcademyInfo(academyIdx: hiphopResultList[indexPath.section].academyIdx, academyImage: hiphopResultList[indexPath.section].academyBackImgUrl, academyName: hiphopResultList[indexPath.section].academyName, academyPhoneNum: hiphopResultList[indexPath.section].academyPhone, academyAddress: hiphopResultList[indexPath.section].academyDetailAddress)
        
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

extension HiphopViewController : specificAcademyProtocol{
    func specificAcademy(result: specificGenreResponse) {
        if result.isSuccess{
            print(result)
            hiphopResultList = result.result ?? []
            HiphopTableView.reloadData()
            mainViewHeight.constant = HiphopTableView.contentSize.height
        }else{
            presentAlert(title: result.message)
        }
    }
    
}

