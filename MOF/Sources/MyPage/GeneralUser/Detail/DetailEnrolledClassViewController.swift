//
//  DetailEnrolledClassViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/03/04.
//

import Foundation
import UIKit
class DetailEnrolledClassViewController : UIViewController{
    
    var enrollInfo = detailEnrollInfo(classType : "", className: "", classTeacherName: "", classTime1: "", classTime2: "", enrollSubmit: "", enrollIdx: -1, classIdx: -1)
    
    var dataManager = UserMyPageDataManager()
    
    @IBOutlet weak var classImageView: UIImageView!
    
    @IBOutlet weak var classNameLabel: UILabel!
    @IBOutlet weak var teacherNameLabel: UILabel!
    @IBOutlet weak var classTime1Label: UILabel!
    @IBOutlet weak var classTime2Label: UILabel!
    @IBOutlet weak var classTime2StackView: UIStackView!
    @IBOutlet weak var classPriceLabel: UILabel!
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userPhoneNumLabel: UILabel!
    @IBOutlet weak var userGenderLabel: UILabel!
    @IBOutlet weak var userAgeLabel: UILabel!
    @IBOutlet weak var enrolledTimeLabel: UILabel!
    @IBOutlet weak var enrollSubmitLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataManager.enrolledInfo(userIdx: KeyCenter.userIndex, enrollIdx: enrollInfo.enrollIdx, delegate: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
    }

}

//MARK:- API
extension  DetailEnrolledClassViewController{
    func enrolledInfo(result : userEnrolledInfoResponse){
        if result.isSuccess{
            
            if let url = URL(string: result.result?[0].classImageUrl ?? "") {
                classImageView.kf.setImage(with: url)
            } else {
                classImageView.image = UIImage(named: "defaultImage")
            }
            
            classNameLabel.text = result.result?[0].className
            teacherNameLabel.text = enrollInfo.classTeacherName
            classTime1Label.text = enrollInfo.classTime1
            if enrollInfo.classTime2 != ""{
                classTime2Label.text = enrollInfo.classTime2
            }else{
                classTime2StackView.isHidden = true
            }
            
            if result.result?[0].classPrice != nil{
                classPriceLabel.text = String(result.result?[0].classPrice ?? 0).insertComma
            }
           
            userNameLabel.text = result.result?[0].userName
            userPhoneNumLabel.text = result.result?[0].userPhone.hyphen()
            
            if result.result?[0].userGender == "Male"{
                userGenderLabel.text = "남성"
            }else{
                userGenderLabel.text = "여성"
            }
            
            userAgeLabel.text = result.result?[0].userAge
            enrolledTimeLabel.text = result.result?[0].enrollTime
            
            if result.result?[0].enrollSubmit == "no"{
                enrollSubmitLabel.text = "승인 이전"
            }else if result.result?[0].enrollSubmit == "YES"{
                enrollSubmitLabel.text = "승인 완료"
            }
            
            
        }else{
            presentAlert(title: result.message)
        }
        
    }
    
    func failedToRequest(){
        
        self.presentAlert(title: "서버와의 연결이 원활하지 않습니다")
    
    }
}

