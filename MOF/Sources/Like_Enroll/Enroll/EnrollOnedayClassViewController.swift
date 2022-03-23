//
//  EnrollOnedayViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/03/12.
//

import Foundation
import UIKit
class EnrollOnedayClassViewController : UIViewController{
    
    lazy var dataManager = EnrollDataManager()
    var onedayClassResultList : [academyOnedayResult] = []
    
    @IBOutlet weak var ondayClassTableView: UITableView!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLoad()
        
        dataManager.academyOnedayClass(academyIdx: KeyCenter.userIndex, delegate: self)
        ondayClassTableView.dataSource = self
        ondayClassTableView.delegate = self
        
        if #available(iOS 15.0, *) {
            ondayClassTableView.sectionHeaderTopPadding = 0
        }
        
    }
    
    
    
}

//MARK:-EXTENSION
extension EnrollOnedayClassViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EnrollOnedayClassTableViewCell", for: indexPath) as! EnrollOnedayClassTableViewCell
        
        cell.academyNameLabel.text = onedayClassResultList[indexPath.section].className
        cell.teacherNameLabel.text = onedayClassResultList[indexPath.section].classTeacherName+" 선생님"
        cell.timeOneLabel.text = onedayClassResultList[indexPath.section].classStartTime1 + onedayClassResultList[indexPath.section].classEndTime1
        
        //Set class time
        let startTime1 = dateToString(date: stringToDate(dateString: onedayClassResultList[indexPath.section].classStartTime1))
        let endTime1 = dateToString(date: stringToDate(dateString: onedayClassResultList[indexPath.section].classEndTime1))
        
        cell.timeOneLabel.text = startTime1 + " ~ " + endTime1

        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return onedayClassResultList.count
        
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailEnrollListViewController")as!DetailEnrollListViewController
        
        //setting info for detailVC
        detailVC.enrollInfo.classType = "oneday"
        detailVC.enrollInfo.classIdx = onedayClassResultList[indexPath.section].classIdx
        detailVC.enrollInfo.className = onedayClassResultList[indexPath.section].className

       self.navigationController?.pushViewController(detailVC, animated: true)
    }
   
}

//MARK:- API
extension EnrollOnedayClassViewController{
    
    func academyOnedayClass(result : academyOnedayResponse){
        if result.isSuccess{
            
            onedayClassResultList = result.result ?? []
            ondayClassTableView.reloadData()
            
        }else{
            presentAlert(title:  result.message)
        }
        
        
        
        
    }
    
    func failedToRequest(){
        
        self.presentAlert(title: "서버와의 연결이 원활하지 않습니다")

    }
    
    
}
