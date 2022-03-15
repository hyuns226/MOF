//
//  LeatherViewController.swift
//  MOF
//
//  Created by 이현서 on 2021/10/26.
//

import UIKit
class GirsHiphopViewController : UIViewController{
    
    var girlsHiphopResultList : [specificResults] = []
    lazy var dataManager = HomeDataManager()
    
    @IBOutlet weak var mainViewHeight: NSLayoutConstraint!
    @IBOutlet weak var GirlsHiphopTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        GirlsHiphopTableView.delegate = self
        GirlsHiphopTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        if HomeViewController.isFiltered{
            
            dataManager.getSpecificAcademy(address: HomeViewController.filterRegion, genre: Constant.GenreList[3], name: "", delegate: self)
            
        }else{
            dataManager.getSpecificAcademy(address: "", genre: Constant.GenreList[3], name: "", delegate: self)
        }
    }
    
}

//MARK: - EXTENSION
extension GirsHiphopViewController : UITableViewDelegate, UITableViewDataSource{
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
        cell.addressLabel.text = girlsHiphopResultList[indexPath.section].academyDetailAddress
        cell.PhoneNumLabel.text = girlsHiphopResultList[indexPath.section].academyPhone
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "AcademyDetaliViewController")as!AcademyDetaliViewController
        detailVC.AcademyInfo = detailAcademyInfo(academyIdx: girlsHiphopResultList[indexPath.section].academyIdx, academyImage: girlsHiphopResultList[indexPath.section].academyBackImgUrl, academyName: girlsHiphopResultList[indexPath.section].academyName, academyPhoneNum: girlsHiphopResultList[indexPath.section].academyPhone, academyAddress: girlsHiphopResultList[indexPath.section].academyDetailAddress)
        
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

extension GirsHiphopViewController : specificAcademyProtocol{
    func specificAcademy(result: specificGenreResponse) {
        if result.isSuccess{
            print(result)
            girlsHiphopResultList = result.result ?? []
            GirlsHiphopTableView.reloadData()
            mainViewHeight.constant = GirlsHiphopTableView.contentSize.height
        }else{
            presentAlert(title: result.message)
        }
    }
    
    
}


