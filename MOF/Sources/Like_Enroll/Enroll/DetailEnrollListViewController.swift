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
        if #available(iOS 15.0, *) {
            enrollListTableView.sectionHeaderTopPadding = 0
        }
        
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
        cell.phoneNumLabel.text = enrollsList[indexPath.row].userPhone.hyphen()
       
       
        
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
        
        cell.callButton.tag = indexPath.row
        cell.callButton.addTarget(self, action: #selector(call(sender:)), for: .touchUpInside)
        
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
            
            
            print("승인")
        }
        
        
    }
    
    @objc func reject(sender : UIButton) {
        
        print(KeyCenter.userIndex,sender.tag )
        
        presentAlert(title: "수업 거절하기", message: "해당 신청자의 수업 신청을 거절합니다.", isCancelActionIncluded: true, preferredStyle: .alert) { (UIAlertAction) in
           
            self.dataManager.rejectClass(academyIdx: KeyCenter.userIndex, enrollIdx: sender.tag, delegate: self)
            
            
            print("거절")
        }
       
        
    }
    
    @objc func call(sender : UIButton){
        print(Int(sender.tag))
        print(enrollsList[sender.tag].userPhone)
        let number : Int = Int(enrollsList[sender.tag].userPhone) ?? 0
            print("tel://0" + "\(number)")
            // URLScheme 문자열을 통해 URL 인스턴스를 만든다
            if let url = NSURL(string: "tel://0" + "\(number)"),
               
            
               //canOpenURL(_:) 메소드를 통해서 URL 체계를 처리하는 데 앱을 사용할 수 있는지 여부를 확인
               UIApplication.shared.canOpenURL(url as URL) {
               
               //사용가능한 URLScheme이라면 open(_:options:completionHandler:) 메소드를 호출해서
               //만들어둔 URL 인스턴스를 열어줍니다.
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
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
            dataManager.classEnrolls(academyIdx: KeyCenter.userIndex, classIdx: enrollInfo.classIdx, delegate: self)
        }else{
            presentAlert(title:  result.message)
        }
    }
    
    func rejectClass(result : approveResponse){
        if result.isSuccess{
            print(result.result)
            presentAlert(title:  "신청 거절이 완료되었습니다.")
            dataManager.classEnrolls(academyIdx: KeyCenter.userIndex, classIdx: enrollInfo.classIdx, delegate: self)
        }else{
            presentAlert(title:  result.message)
        }
    }
    
    func failedToRequest(){
        
        self.presentAlert(title: "서버와의 연결이 원활하지 않습니다")

    }
}

