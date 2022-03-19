//
//  AllViewController.swift
//  MOF
//
//  Created by 이현서 on 2021/10/26.
//

import UIKit
class KpopViewController : UIViewController{
    
    var kpopResultList : [specificResults] = []
    lazy var dataManager = HomeDataManager()
    
    @IBOutlet weak var mainViewHeight: NSLayoutConstraint!
    @IBOutlet weak var KpopTableView: UITableView!
    
    @IBOutlet weak var emptyView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        KpopTableView.dataSource = self
        KpopTableView.delegate = self
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        if HomeViewController.isFiltered{
            
            dataManager.getSpecificAcademy(address: HomeViewController.filterRegion, genre: Constant.GenreList[0], name: "", delegate: self)
            
        }else{
            dataManager.getSpecificAcademy(address: "", genre: Constant.GenreList[0], name: "", delegate: self)
        }
        
        
    }
    

     

}

extension KpopViewController : UITableViewDelegate, UITableViewDataSource{
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
        cell.addressLabel.text = kpopResultList[indexPath.section].academyDetailAddress
        cell.PhoneNumLabel.text = kpopResultList[indexPath.section].academyPhone.hyphen()
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "AcademyDetaliViewController")as!AcademyDetaliViewController
        detailVC.AcademyInfo = detailAcademyInfo(academyIdx: kpopResultList[indexPath.section].academyIdx, academyImage: kpopResultList[indexPath.section].academyBackImgUrl, academyName: kpopResultList[indexPath.section].academyName, academyPhoneNum: kpopResultList[indexPath.section].academyPhone, academyAddress: kpopResultList[indexPath.section].academyDetailAddress)
        
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

extension KpopViewController : specificAcademyProtocol{
    func specificAcademy(result: specificGenreResponse) {
        if result.isSuccess{
            print(result)
            kpopResultList = result.result ?? []
            if kpopResultList.count == 0{
                emptyView.isHidden = false
            }else{
                KpopTableView.reloadData()
                mainViewHeight.constant = KpopTableView.contentSize.height
            }
            
        }else{
            presentAlert(title: result.message)
        }
    }
    
    
}


