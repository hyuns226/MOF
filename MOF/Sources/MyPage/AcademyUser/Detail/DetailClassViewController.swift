//
//  DetailClassViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/03/01.
//

import Foundation
import UIKit
class DetailClassViewController : UIViewController{
    
    var classIdx = -1
    var classType = ""
    
    var classTimeList : [classTime] = []
    
    var classInfoForEnrollVC =  classInfoForEnrollment(classIdx: -1, classImageUrl: "", className: "", teacherName: "", classTimeList: [] , classPrice: "", priceOnlyNum : -1)
        
    lazy var dataManager = AcademyMyPageDataManager()
    
    @IBOutlet weak var classImageView: UIImageView!
    @IBOutlet weak var classNameLabel: UILabel!
    @IBOutlet weak var classTimeCollectionView: UICollectionView!
    @IBOutlet weak var classPriceLabel: UILabel!
    @IBOutlet weak var classPersonnelLabel: UILabel!
    @IBOutlet weak var classIntroLabel: UILabel!
    @IBOutlet weak var teacherImageView: UIImageView!
    @IBOutlet weak var teacherNameLabel: UILabel!
    @IBOutlet weak var teacherIntroLabel: UILabel!
    
  
    @IBOutlet weak var modifyClassButton: UIButton!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //네비게이션 hidden상태에서 뒤로가기 제스쳐
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        print("classIdx :\(classIdx)")
        
        classInfoForEnrollVC.classIdx = self.classIdx
        
        if classType == "regular"{
            dataManager.getDetailRegularClasses(classIdx: classIdx, delegate: self)
        }else if classType == "oneday"{
            dataManager.getDetailOnedayClasses(classIdx: classIdx, delegate: self)
        }
        
        
        modifyClassButton.layer.cornerRadius = 18
       
            
        
        classTimeCollectionView.delegate = self
        classTimeCollectionView.dataSource = self
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
       
        //change status bar color to light
        UIApplication.shared.statusBarStyle = .lightContent
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    
    //MARK:- FUNCTION
   
    
    @IBAction func modifyClassButtonAction(_ sender: Any) {
        let modifyVC = self.storyboard?.instantiateViewController(withIdentifier: "modifyClassViewController") as! ModifyClassViewController
        
        modifyVC.classType = self.classType
        print("classtype :\(self.classType)")
        
        modifyVC.modalPresentationStyle = .fullScreen
        self.present(modifyVC, animated: true, completion: nil)
    }
}

extension DetailClassViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return classTimeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DetailClassCollectionViewCell", for: indexPath) as! DetailClassCollectionViewCell
           cell.layer.borderColor = #colorLiteral(red: 0.9341395497, green: 0.9341614842, blue: 0.9341497421, alpha: 1)
           cell.layer.borderWidth = 1
        
        cell.dayLabel.text = classTimeList[indexPath.item].day
        cell.timeLabel.text = classTimeList[indexPath.item].time
        
        return cell
    }
    

}

//MARK:- API
extension DetailClassViewController{
    
    func getDetailRegularClass(result : detailRegularClassResponse){
        if result.isSuccess{
            print(result)
            
            if let url = URL(string: result.result?.classImageUrl ?? "") {
                classImageView.kf.setImage(with: url)
            } else {
                classImageView.image = UIImage(named: "defaultImage")
            }
            
            classNameLabel.text = result.result?.className
            
            //Set class time
            let day1 = dateToStringOnlyDay(date: stringToDateForDayandDate(dateString: result.result?.classStartTime1 ?? ""))
            let startTime1 = dateToStringOnlyTime(date: stringToDateForDayandDate(dateString: result.result?.classStartTime1 ?? ""))
            let endTime1 = dateToStringOnlyTime(date: stringToDateForDayandDate(dateString: result.result?.classEndTime1 ?? ""))
            classTimeList.append(classTime(day: day1, time: startTime1 + "~" + endTime1))
            
            if result.result?.classStartTime2 != nil{
                let day2 = dateToStringOnlyDay(date: stringToDateForDayandDate(dateString: result.result?.classStartTime1 ?? ""))
                let startTime2 = dateToStringOnlyTime(date: stringToDateForDayandDate(dateString: result.result?.classStartTime2 ?? ""))
                let endTime2 = dateToStringOnlyTime(date: stringToDateForDayandDate(dateString: result.result?.classEndTime2 ?? ""))
                classTimeList.append(classTime(day: day2, time: startTime2 + "~" + endTime2))
                
            }
            
            classTimeCollectionView.reloadData()
                
            if let price = result.result?.classPrice{
                classPriceLabel.text =  String(result.result?.classPrice ?? -1).insertComma+"원"
            }else{
                classPriceLabel.text = ""
            }

            
            if (result.result?.classPersonnel) != nil{
                print(result.result?.classPersonnel)
                classPersonnelLabel.text =  String((result.result?.classPersonnel)!) + "명"
            }
            classIntroLabel.text = result.result?.classIntro
            
            
            if let url = URL(string: result.result?.teacherImgUrl ?? "") {
                teacherImageView.kf.setImage(with: url)
            } else {
                teacherImageView.image = UIImage(named: "defaultImage")
            }
           
            teacherNameLabel.text = result.result?.classTeacherName
            teacherIntroLabel.text = result.result?.classTeacherIntro
             
            //setting classinfo for classEnrollmentVC
            classInfoForEnrollVC.classImageUrl = result.result?.classImageUrl ?? ""
            classInfoForEnrollVC.className = result.result?.className ?? ""
            classInfoForEnrollVC.teacherName = result.result?.classTeacherName ?? ""
            classInfoForEnrollVC.classTimeList.append(day1 + " / " + startTime1 + " ~ " + endTime1)
            if result.result?.classStartTime2 != nil{
                let day2 = dateToStringOnlyDay(date: stringToDateForDayandDate(dateString: result.result?.classStartTime1 ?? ""))
                let startTime2 = dateToStringOnlyTime(date: stringToDateForDayandDate(dateString: result.result?.classStartTime2 ?? ""))
                let endTime2 = dateToStringOnlyTime(date: stringToDateForDayandDate(dateString: result.result?.classEndTime2 ?? ""))
                classInfoForEnrollVC.classTimeList.append(day2 + " / " + startTime2 + " ~ " + endTime2)
            }
            classInfoForEnrollVC.classPrice = String(result.result?.classPrice ?? -1).insertComma+"원"
            classInfoForEnrollVC.priceOnlyNum = result.result?.classPrice ?? -1
            
            ModifyClassViewController.regularClassInfo = result.result ?? detailRegularClassResults(classIdx: -1, classImageUrl: "", className: "", classPrice: 0, classPersonnel: 0, classType: "", classStartTime1: "", classEndTime1: "", classStartTime2: "", classEndTime2: "", classIntro: "", teacherImgUrl: "", classTeacherName: "", classTeacherIntro: "", classGernre: "")
        }else{
            presentAlert(title: result.message)
        }
        
       
        
    }
    
    func getDetailOnedayClass(result : detailOnedayClassResponse){
        if result.isSuccess{
            print(result)
            
            if let url = URL(string: result.result?.classImageUrl ?? "") {
                classImageView.kf.setImage(with: url)
                
            } else {
                classImageView.image = UIImage(named: "defaultImage")
            }
            
            classNameLabel.text = result.result?.className
           
            
            //Set class time
            let date1 = dateToStringOnlyDate(date: stringToDateForOneday(dateString: result.result?.classStartTime1 ?? ""))
            let startTime1 = dateToStringOnlyTime(date: stringToDateForOneday(dateString: result.result?.classStartTime1 ?? ""))
            let endTime1 = dateToStringOnlyTime(date: stringToDateForOneday(dateString: result.result?.classEndTime1 ?? ""))
            classTimeList.append(classTime(day: date1, time: startTime1 + "~" + endTime1))
            
            
            
            classTimeCollectionView.reloadData()
                
            if let price = result.result?.classPrice{
                classPriceLabel.text =  String(result.result?.classPrice ?? -1).insertComma+"원"
                
            }else{
                classPriceLabel.text = ""
            }

            
            if result.result?.classPersonnel != nil{
                classPersonnelLabel.text =  String((result.result?.classPersonnel)!) + "명"
            }
            classIntroLabel.text = result.result?.classIntro
            
            
           
            
            
            if let url = URL(string: result.result?.teacherImgUrl ?? "") {
                teacherImageView.kf.setImage(with: url)
            } else {
                teacherImageView.image = UIImage(named: "defaultImage")
            }
           
            teacherNameLabel.text = result.result?.classTeacherName
            teacherIntroLabel.text = result.result?.classTeacherIntro
            
            
            //setting classinfo for classEnrollmentVC
            classInfoForEnrollVC.classImageUrl = result.result?.classImageUrl ?? ""
            classInfoForEnrollVC.className = result.result?.className ?? ""
            classInfoForEnrollVC.teacherName = result.result?.classTeacherName ?? ""
            classInfoForEnrollVC.classTimeList.append(date1 + " / " + startTime1 + " ~ " + endTime1)
            classInfoForEnrollVC.classPrice = String(result.result?.classPrice ?? -1).insertComma+"원"
            classInfoForEnrollVC.priceOnlyNum = result.result?.classPrice ?? -1
            
            ModifyClassViewController.onedayClassInfo = result.result ?? detailOnedayClassResults(classIdx: -1, classImageUrl: "", className: "", classPrice: 0, classPersonnel: 0, classType: "", classStartTime1: "", classEndTime1: "", classIntro: "", teacherImgUrl: "", classTeacherName: "", classTeacherIntro: "", classGernre: "")
            
        }else{
            presentAlert(title: result.message)
        }
        
        
    }
    
    func failedToRequest(){
        
        self.presentAlert(title: "서버와의 연결이 원활하지 않습니다")
    
    }
    
    
    
    
}
