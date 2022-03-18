//
//  MyRegularClassViewontroller.swift
//  MOF
//
//  Created by 이현서 on 2021/12/02.
//

import UIKit
class MyRegularClassViewontroller : UIViewController{
    
    lazy var dataManager = UserMyPageDataManager()
    
    var regularClasses : [regularResults?] = []

    var forenrollVCInfo = detailEnrollInfo(classType : "", className: "", classTeacherName: "", classTime1: "", classTime2: "", enrollSubmit: "", enrollIdx: -1, classIdx: -1)
    
    @IBOutlet weak var regularClassTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        regularClassTableView.dataSource = self
        regularClassTableView.delegate = self
        
        dataManager.regularClass(userIdx: KeyCenter.userIndex, delegate: self)
    }
        
    
    
    
    
    
    
    
}


//MARK:-EXTENSION

extension MyRegularClassViewontroller : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MYRegularClassTableViewCell", for: indexPath) as! MYRegularClassTableViewCell
        
        
        cell.academyNameLabel.text = regularClasses[indexPath.row]!.className
        cell.teacherNameLabel.text =  regularClasses[indexPath.row]!.classTeacherName + " 선생님"
        
        //Set class time
        let startTime1 = dateToString(date: stringToDateForDayandDate(dateString: regularClasses[indexPath.row]!.classStartTime1))
        let endTime1 = dateToStringOnlyTime(date: stringToDateForDayandDate(dateString: regularClasses[indexPath.row]!.classEndTime1))
        
        cell.timeOneLabel.text = startTime1 + " ~ " + endTime1
        forenrollVCInfo.classTime1 = startTime1 + " ~ " + endTime1
        
        if regularClasses[indexPath.row]!.classStartTime2 != nil{
            let startTime2 = dateToString(date: stringToDateForDayandDate(dateString: regularClasses[indexPath.row]!.classStartTime2 ?? ""))
            let endTime2 = dateToStringOnlyTime(date: stringToDateForDayandDate(dateString: regularClasses[indexPath.row]!.classEndTime2 ?? ""))
            
            cell.timeTwoLabel.text = startTime2 + " ~ " + endTime2
            forenrollVCInfo.classTime2 = startTime2 + " ~ " + endTime2
        }else{
            
            cell.timeTwoLabel.isHidden = true
        }
        
        
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return regularClasses.count
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
        forenrollVCInfo.classType = "regular"
        forenrollVCInfo.classIdx = regularClasses[indexPath.row]?.classIdx ?? -1
        forenrollVCInfo.className = regularClasses[indexPath.row]?.className ?? ""
        forenrollVCInfo.classTeacherName = regularClasses[indexPath.row]?.classTeacherName ?? ""
        forenrollVCInfo.enrollIdx = regularClasses[indexPath.row]?.enrollIdx ?? -1
        forenrollVCInfo.enrollSubmit = regularClasses[indexPath.row]?.enrollSubmit ?? ""
        
        enrolledVC.enrollInfo = self.forenrollVCInfo
        
       self.navigationController?.pushViewController(enrolledVC, animated: true)
    }
    
}


//MARK: - API
extension MyRegularClassViewontroller{
    
    
    func regularClass(result : userRegularClassResponse){
        if result.isSuccess == true{
            print(result)
            
            regularClasses = result.result ?? []
            regularClassTableView.reloadData()
            
            
            
            
            
            
        }else{
            self.presentAlert(title: result.message)
            
        }
    
    }
    
    func failedToRequest(){
        
        self.presentAlert(title: "서버와의 연결이 원활하지 않습니다")
    
    }
    
    
}
