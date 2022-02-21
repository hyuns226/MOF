//
//  AcademyOnedayClassViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/02/13.
//

import Foundation
import UIKit
class AcademyOnedayClassViewController : UIViewController{
    
    lazy var dataManager = AcademyMyPageDataManager()
    
    var onedayClassResultList : [academyOnedayResult] = []
    
    @IBOutlet weak var onedayClassTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        dataManager.academyOnedayClass(academyIdx: 1, delegate: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        onedayClassTableView.dataSource = self
        onedayClassTableView.delegate = self
        
    }
    
    
    
}

//MARK:- EXTENSION
extension AcademyOnedayClassViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AcademyOnedayClassTableViewTableViewCell", for: indexPath) as! AcademyOnedayClassTableViewTableViewCell
        
        cell.layer.cornerRadius = 19
        
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

    
}

//MARK:- API
extension AcademyOnedayClassViewController{
    
    func academyOnedayClass(result : academyOnedayResponse){
        if result.isSuccess{
            
            onedayClassResultList = result.result ?? []
            onedayClassTableView.reloadData()
            
        }else{
            presentAlert(title:  result.message)
        }
        
        
        
        
    }
    
    func failedToRequest(){
        
        self.presentAlert(title: "서버와의 연결이 원활하지 않습니다")

    }
    
    
}
