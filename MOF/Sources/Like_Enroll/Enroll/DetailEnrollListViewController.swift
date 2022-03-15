//
//  DetailEnrollListViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/03/12.
//

import Foundation
import UIKit
class  DetailEnrollListViewController : UIViewController{
    
    var enrollInfo = detailEnrollsInfo(classType : "", className: "",  classIdx: -1)
    
    var enrollsList : [detailEnrollResults] = []
    
    var dataManager = EnrollDataManager()
    
    @IBOutlet weak var enrollListTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(enrollInfo)
        self.navigationItem.title = "\(enrollInfo.className)의 수강 신청 내역"
        
        //back button color
        navigationController?.navigationBar.tintColor = UIColor(hex: 0x2E3A59)
        
        dataManager.classEnrolls(academyIdx: KeyCenter.userIndex, classIdx: enrollInfo.classIdx, delegate: self)
        
        enrollListTableView.dataSource = self
        enrollListTableView.delegate = self
        
    }
    
    
    
}

//MARK:- EXTENSION

extension DetailEnrollListViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EnrollListTableViewCell") as! EnrollListTableViewCell
        
        cell.nameLabel.text = enrollsList[indexPath.row].userName
        cell.phoneNumLabel.text = enrollsList[indexPath.row].userPhone
       
       
        
        if enrollsList[indexPath.row].userGender == "Male"{
            cell.genderLabel.text = "남성"
        }else{
            cell.genderLabel.text = "여성"
        }
        
        cell.ageLabel.text = enrollsList[indexPath.row].userAge
        
        cell.enrolledTimeLabel.text = enrollsList[indexPath.row].createdAt
        
        
        if enrollsList[indexPath.row].enrollSubmit == "YES"{
            cell.approveButton.isEnabled = false
            cell.approveButton.setTitle("승인 완료", for: .normal)
            cell.approveButton.backgroundColor = #colorLiteral(red: 0.6980392157, green: 0.6980392157, blue: 0.6980392157, alpha: 1)
            cell.refuseButton.isHidden = true
            
        }else if enrollsList[indexPath.row].enrollSubmit == "REJECTED"{
            cell.refuseButton.isEnabled = false
            cell.refuseButton.setTitle("거절 완료", for: .normal)
            cell.refuseButton.backgroundColor = #colorLiteral(red: 0.6980392157, green: 0.6980392157, blue: 0.6980392157, alpha: 1)
            cell.approveButton.isHidden = true
            
        }else{ //"no"
            
        }
        
        cell.approveButton.tag =  enrollsList[indexPath.row].enrollIdx
        cell.approveButton.addTarget(self, action: #selector(approve(sender:)), for: .touchUpInside)
        
        cell.refuseButton.tag = enrollsList[indexPath.row].enrollIdx
        cell.refuseButton.addTarget(self, action: #selector(reject(sender:)), for: .touchUpInside)
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return enrollsList.count
       
    }

    
    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }

    // Make the background color show through
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        return headerView
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    }
    
    @objc func approve(sender : UIButton) {
        
        print(KeyCenter.userIndex,sender.tag )
        
        presentAlert(title: "수업 승인하기", message: "해당 신청자의 수업 신청을 승인합니다.", isCancelActionIncluded: true, preferredStyle: .alert) { (UIAlertAction) in
            self.dataManager.approveClass(academyIdx: KeyCenter.userIndex, enrollIdx: sender.tag, delegate: self)
            self.enrollListTableView.reloadData()
            print("승인")
        }
        
    }
    
    @objc func reject(sender : UIButton) {
        
        print(KeyCenter.userIndex,sender.tag )
        
        presentAlert(title: "수업 거절하기", message: "해당 신청자의 수업 신청을 거절합니다.", isCancelActionIncluded: true, preferredStyle: .alert) { (UIAlertAction) in
           
            self.dataManager.rejectClass(academyIdx: KeyCenter.userIndex, enrollIdx: sender.tag, delegate: self)
            self.enrollListTableView.reloadData()
            print("거절")
        }
        
    }
    
    
    

    
}

//MARK: API
extension DetailEnrollListViewController{
    func classEnrolls(result : detailEnrollsResponse){
        if result.isSuccess{
            enrollsList = result.result ?? []
            print(enrollsList)
            enrollListTableView.reloadData()
            
            
        }else{
            presentAlert(title:  result.message)
        }
        
    }
    
    func approveClass(result : approveResponse){
        if result.isSuccess{
            print(result.result)
            presentAlert(title:  "신청 승인이 완료되었습니다.")
        }else{
            presentAlert(title:  result.message)
        }
    }
    
    func rejectClass(result : approveResponse){
        if result.isSuccess{
            print(result.result)
            presentAlert(title:  "신청 거절이 완료되었습니다.")
        }else{
            presentAlert(title:  result.message)
        }
    }
    
    func failedToRequest(){
        
        self.presentAlert(title: "서버와의 연결이 원활하지 않습니다")

    }
}

