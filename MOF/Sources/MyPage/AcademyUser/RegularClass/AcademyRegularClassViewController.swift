//
//  AcademyRegularClassViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/02/13.
//

import Foundation
import UIKit

class AcademyRegularClassViewController : UIViewController{
    
    @IBOutlet var mainView: UIView!
    lazy var dataManager = AcademyMyPageDataManager()
    
    var regularClassResultList : [academyRegularResult] = []
    
    var tablevieHeight : CGFloat = 0.0
    
    
    @IBOutlet weak var regularClassTableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
      
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        
        regularClassTableView.dataSource = self
        regularClassTableView.delegate = self
        if #available(iOS 15.0, *) {
            regularClassTableView.sectionHeaderTopPadding = 0
        }
        
        dataManager.academyRegularClass(academyIdx: KeyCenter.userIndex, delegate: self)
    }
    
    
    
}

//MARK:- EXTENSION
extension AcademyRegularClassViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AcademyRegularClassTableViewCell", for: indexPath) as! AcademyRegularClassTableViewCell
        cell.layer.cornerRadius = 19


        cell.academyNameLabel.text = regularClassResultList[indexPath.section].className
        cell.teacherNameLabel.text = regularClassResultList[indexPath.section].classTeacherName+" 선생님"

        //Set class time
        let startTime1 = dateToString(date: stringToDate(dateString: regularClassResultList[indexPath.section].classStartTime1))
        let endTime1 = dateToString(date: stringToDate(dateString: regularClassResultList[indexPath.section].classEndTime1))

        cell.timeOneLabel.text = startTime1 + " ~ " + endTime1

        if regularClassResultList[indexPath.section].classStartTime2 != nil{
            let startTime2 = dateToString(date: stringToDate(dateString: regularClassResultList[indexPath.section].classStartTime2 ?? ""))
            let endTime2 = dateToString(date: stringToDate(dateString: regularClassResultList[indexPath.section].classEndTime2 ?? ""))

            cell.timeTwoLabel.text = startTime2 + " ~ " + endTime2
        }else{

            cell.timeTwoLabel.isHidden = true
        }
        
       return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
       return regularClassResultList.count
      
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
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailClassViewController")as!DetailClassViewController
        detailVC.classIdx = regularClassResultList[indexPath.section].classIdx
        detailVC.classType = "regular"
        self.navigationController?.pushViewController(detailVC, animated: true)
    }

    
}

//MARK:- API
extension AcademyRegularClassViewController{
    
    func academyRegularClass(result : academyRegularResponse){
        if result.isSuccess{
            
            print(result)
            regularClassResultList = result.result ?? []
            regularClassTableView.reloadData()
           
            
            
        }else{
            presentAlert(title:  result.message)
        }
    }
    
    func failedToRequest(){
        
        self.presentAlert(title: "서버와의 연결이 원활하지 않습니다")

    }
    
    
}
