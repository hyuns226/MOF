//
//  MyOnedayViewController.swift
//  MOF
//
//  Created by 이현서 on 2021/12/02.
//

import UIKit
class MyOnedayViewController : UIViewController{
    
    lazy var dataManager = UserMyPageDataManager()
    var ondayClasses : [onedayResults?] = []
    
    var forenrollVCInfo = detailEnrollInfo(classType : "", className: "", classTeacherName: "", classTime1: "", classTime2: "", enrollSubmit: "", enrollIdx: -1, classIdx: -1)
    
    @IBOutlet weak var ondayClassTableView: UITableView!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLoad()
        
        ondayClassTableView.dataSource = self
        ondayClassTableView.delegate = self
        
        dataManager.onedayClass(userIdx: KeyCenter.userIndex, delegate: self)
    }
    
    
    

}

//MARK:-EXTENSION
extension MyOnedayViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MYOnedayClassTableViewCell", for: indexPath) as! MYOnedayClassTableViewCell
        
        cell.academyNameLabel.text = ondayClasses[indexPath.row]?.className
        cell.teacherNameLabel.text = ondayClasses[indexPath.row]!.classTeacherName+" 선생님"
        
        //Set class time
        let startTime1 = dateToStringOnlyDate(date: stringToDateAll(dateString: ondayClasses[indexPath.row]!.classStartTime1))
        let startDate = dateToStringOnlyTime(date: stringToDateAll(dateString: ondayClasses[indexPath.row]!.classStartTime1))
        let endTime1 = dateToStringOnlyTime(date: stringToDateAll(dateString: ondayClasses[indexPath.row]!.classEndTime1))
        
        cell.timeOneLabel.text = startTime1 + " " + startDate + " ~ " + endTime1
        
        forenrollVCInfo.classTime1 = startTime1 + " " + startDate + " ~ " + endTime1
        
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return ondayClasses.count
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
        let enrolledVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailEnrolledClassViewController")as!DetailEnrolledClassViewController

        //setting info for enrollVC
        forenrollVCInfo.classType = "oneday"
        forenrollVCInfo.classIdx = ondayClasses[indexPath.row]?.classIdx ?? -1
        forenrollVCInfo.className = ondayClasses[indexPath.row]?.className ?? ""
        forenrollVCInfo.classTeacherName = ondayClasses[indexPath.row]?.classTeacherName ?? ""
        forenrollVCInfo.enrollIdx = ondayClasses[indexPath.row]?.enrollIdx ?? -1
        forenrollVCInfo.enrollSubmit = ondayClasses[indexPath.row]?.enrollSubmit ?? ""
        
        enrolledVC.enrollInfo = self.forenrollVCInfo
        
        self.navigationController?.pushViewController(enrolledVC, animated: true)
    }
    
    
    
   
}


//MARK: - API
extension MyOnedayViewController{
    
    
    func onedayClass(result : userOnedayClassResponse){
        if result.isSuccess == true{
            print(result)
            ondayClasses = result.result ?? []
            ondayClassTableView.reloadData()
            
            
        }else{
            self.presentAlert(title: result.message)
            
        }
    
    }
    
    func failedToRequest(){
        
        self.presentAlert(title: "서버와의 연결이 원활하지 않습니다")
    
    }
    
    
}
