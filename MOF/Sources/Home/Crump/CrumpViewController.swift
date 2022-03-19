//
//  CrumpViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/01/05.
//

import UIKit
class CrumpViewController : UIViewController {
    
     var crumpResultList : [specificResults] = []
    lazy var dataManager = HomeDataManager()
    
    @IBOutlet weak var mainViewHeight: NSLayoutConstraint!
    @IBOutlet weak var CrumpTableView: UITableView!
    
    @IBOutlet weak var emptyView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        CrumpTableView.delegate = self
        CrumpTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        if HomeViewController.isFiltered{
            
            dataManager.getSpecificAcademy(address: HomeViewController.filterRegion, genre: Constant.GenreList[7], name: "", delegate: self)
            
        }else{
            dataManager.getSpecificAcademy(address: "", genre: Constant.GenreList[7], name: "", delegate: self)
        }
    }
    
}

//MARK:- EXTENSION
extension CrumpViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CrumpTableViewCell")as!CrumpTableViewCell
        cell.layer.cornerRadius = 12
        
        if let url = URL(string: crumpResultList[indexPath.section].academyBackImgUrl ?? "") {
            cell.AcademyImageView.kf.setImage(with: url)
        } else {
            cell.AcademyImageView.image = UIImage(named: "defaultImage")
        }
        
        cell.AcademyName.text = crumpResultList[indexPath.section].academyName
        cell.addressLabel.text = crumpResultList[indexPath.section].academyDetailAddress
        cell.PhoneNumLabel.text = crumpResultList[indexPath.section].academyPhone.hyphen()
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "AcademyDetaliViewController")as!AcademyDetaliViewController
        detailVC.AcademyInfo = detailAcademyInfo(academyIdx: crumpResultList[indexPath.section].academyIdx, academyImage: crumpResultList[indexPath.section].academyBackImgUrl, academyName: crumpResultList[indexPath.section].academyName, academyPhoneNum: crumpResultList[indexPath.section].academyPhone, academyAddress: crumpResultList[indexPath.section].academyDetailAddress)
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
    // MARK: - Table View delegate methods

        func numberOfSections(in tableView: UITableView) -> Int {
            return crumpResultList.count
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

extension CrumpViewController : specificAcademyProtocol{
    func specificAcademy(result: specificGenreResponse) {
        if result.isSuccess{
            print(result)
            crumpResultList = result.result ?? []
            if crumpResultList.count == 0{
                emptyView.isHidden = false
            }else{
                CrumpTableView.reloadData()
                mainViewHeight.constant = CrumpTableView.contentSize.height
            }
            
        }else{
            presentAlert(title: result.message)
        }
    }
    
    
}

