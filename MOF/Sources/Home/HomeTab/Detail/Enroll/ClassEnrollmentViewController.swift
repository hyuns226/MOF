//
//  ClassEnrollment.swift
//  MOF
//
//  Created by 이현서 on 2022/02/23.
//

import Foundation
import UIKit

struct classInfoForEnrollment{
    var classIdx : Int
    var classImageUrl : String
    var className  : String
    var teacherName : String
    var classTimeList : [String] 
    var classPrice : String
    var priceOnlyNum : Int
}

class ClassEnrollmentViewController : UIViewController{
    
    var classInfo =  classInfoForEnrollment(classIdx : -1, classImageUrl: "", className: "", teacherName: "", classTimeList: [], classPrice: "" , priceOnlyNum: -1)
    
    lazy var dataManager = HomeDataManager()
    
    @IBOutlet weak var classImageView: UIImageView!
    @IBOutlet weak var classNameLabel: UILabel!
    
    @IBOutlet weak var teacherNameLabel: UILabel!
    @IBOutlet weak var classTimeLabel: UILabel!
    @IBOutlet weak var classTimeLabel2: UILabel!
    @IBOutlet weak var classPriceLabel: UILabel!
    @IBOutlet weak var classTime2StackView: UIStackView!
    
    
    @IBOutlet weak var studentNameLabel: UILabel!
    @IBOutlet weak var studentPhoneNumLabel: UILabel!
    @IBOutlet weak var studentGenderLabel: UILabel!
    @IBOutlet weak var studentAgeLabel: UILabel!
    
    
    @IBOutlet weak var enrollButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingClassInfo()
        settingMyInfo()
        
        //1. 수업정보 앞에서 가져오기, 2.내정보 불러오기, 3. 등록하기 api
    }
    
    func settingClassInfo(){
        if let url = URL(string: classInfo.classImageUrl) {
            classImageView.kf.setImage(with: url)
            
        } else {
            classImageView.image = UIImage(named: "defaultImage")
        }
        classNameLabel.text = classInfo.className
        teacherNameLabel.text = classInfo.teacherName
        classTimeLabel.text = classInfo.classTimeList[0]
        if classInfo.classTimeList.count>1{
            classTimeLabel2.text = classInfo.classTimeList[1]
        }else{
            classTime2StackView.isHidden = true
        }
        classPriceLabel.text = classInfo.classPrice
    
    }
    
    func settingMyInfo(){
        dataManager.userProfile(userIdx: KeyCenter.userIndex, delegate: self)
        
    }
    
    @IBAction func enrollButtonAction(_ sender: Any) {
        
        
        
        
        print("등록 가격:\(classInfo.priceOnlyNum)")
        print("등록 클래스 : \(classInfo.classIdx)")
        
        dataManager.enrollClass(parameters: classEnrollRequest(enrollCost: classInfo.priceOnlyNum) , userIdx: KeyCenter.userIndex, classIdx: classInfo.classIdx, delegate: self)
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

//MARK:- API
extension ClassEnrollmentViewController{
    
    func userProfile(result : userProfileResponse){
        if result.isSuccess{
            studentNameLabel.text = result.result?.userName
            studentPhoneNumLabel.text = result.result?.userPhone
            if result.result?.userGender == "Female"{
                studentGenderLabel.text = "여성"
            }else{
                studentGenderLabel.text = "남성"
            }
           
            studentAgeLabel.text = result.result?.userAge
        }else{
            presentAlert(title: result.message)
        }
        
    }
    
    func enrollClass(result : classEnrollResponse){
        
        if result.isSuccess{
            print(result)
            print("신청성공함")
            
            // 신청성공 뷰로 전환
            let completeVC = self.storyboard?.instantiateViewController(withIdentifier: "CompleteEnrollmentViewController") as! CompleteEnrollmentViewController
            completeVC.classImage = self.classImageView.image
            completeVC.modalPresentationStyle = .fullScreen
            self.present(completeVC, animated: false, completion: nil)
        }else{
            presentAlert(title: result.message)
        }
        
        
    }
    
    func failedToRequest(){
        
        self.presentAlert(title: "서버와의 연결이 원활하지 않습니다")
    
    }

}
