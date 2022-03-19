//
//  ClassDetailViewController.swift
//  MOF
//
//  Created by 이현서 on 2021/11/16.
//

import UIKit
class ClassDetailViewController : UIViewController{
    
    
    var classIdx = -1
    var classType = ""
    var academyPhoneNum = ""
    
    var classTimeList : [classTime] = []
    
    var classInfoForEnrollVC =  classInfoForEnrollment(classIdx: -1, classImageUrl: "", className: "", teacherName: "", classTimeList: [] , classPrice: "", priceOnlyNum : -1)
        
    lazy var dataManager = HomeDataManager()
    
    @IBOutlet weak var classImageView: UIImageView!
    @IBOutlet weak var classNameLabel: UILabel!
    @IBOutlet weak var classTimeCollectionView: UICollectionView!
    @IBOutlet weak var classPriceLabel: UILabel!
    @IBOutlet weak var classPersonnelLabel: UILabel!
    @IBOutlet weak var classIntroLabel: UILabel!
    @IBOutlet weak var teacherImageView: UIImageView!
    @IBOutlet weak var teacherNameLabel: UILabel!
    @IBOutlet weak var teacherIntroLabel: UILabel!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var AskButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("classIdx :\(classIdx)")
        
        classInfoForEnrollVC.classIdx = self.classIdx
        
        if classType == "regular"{
            dataManager.getDetailRegularClasses(classIdx: classIdx, delegate: self)
        }else if classType == "oneday"{
            dataManager.getDetailOnedayClasses(classIdx: classIdx, delegate: self)
        }
        
        
        AskButton.layer.cornerRadius = 18
        registerButton.layer.cornerRadius = 18
            
        //setting Likes Button
        if KeyCenter.userType == "general"{
            dataManager.getClassLikes(userIdx: KeyCenter.userIndex, classIdx: classIdx, delegate: self)
        }else{
            likeButton.isHidden = true
        }
        
        
        classTimeCollectionView.delegate = self
        classTimeCollectionView.dataSource = self
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
       
        //change status bar color to light
        UIApplication.shared.statusBarStyle = .lightContent
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    

    
    //MARK:- FUNCTION
   
    @IBAction func likeButtonAction(_ sender: Any) {
        likeButton.isSelected =  !likeButton.isSelected
      
        if likeButton.isSelected == true{
            dataManager.likesForClass(userIdx: KeyCenter.userIndex, classIdx: classIdx, delegate: self)
            
            
        }else{
            dataManager.dislikesForClass(userIdx: KeyCenter.userIndex, classIdx: classIdx, delegate: self)
            
        }
    }
    @IBAction func enrollButtonAction(_ sender: Any) {
        let enrollVC = self.storyboard?.instantiateViewController(withIdentifier: "ClassEnrollmentViewController") as! ClassEnrollmentViewController
        
        enrollVC.classInfo = self.classInfoForEnrollVC
        
        enrollVC.modalPresentationStyle = .fullScreen
        self.present(enrollVC, animated: true, completion: nil)
    }
    
    @IBAction func askButtonAction(_ sender: Any) {
        print(Int(self.academyPhoneNum))
        print(self.academyPhoneNum)
        let number : Int = Int(self.academyPhoneNum) ?? 0
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

extension ClassDetailViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return classTimeList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClassTimeCollectionViewCell", for: indexPath) as! ClassTimeCollectionViewCell
           cell.layer.borderColor = #colorLiteral(red: 0.9341395497, green: 0.9341614842, blue: 0.9341497421, alpha: 1)
           cell.layer.borderWidth = 1
        
        cell.dayLabel.text = classTimeList[indexPath.item].day
        cell.timeLabel.text = classTimeList[indexPath.item].time
        
        return cell
    }
    

}

//MARK:- API
extension ClassDetailViewController{
    
    func getClassLikes(result : getAcademyLikesResponse){
        if result.isSuccess{
            print(result.result.좋아요여부)
            if result.result.좋아요여부 == true{
                self.likeButton.isSelected = true
                self.likeButton.setImage(#imageLiteral(resourceName: "heart_fill"), for: .selected)
                print("yes")
            }else{
                self.likeButton.isSelected = false
                self.likeButton.setImage(#imageLiteral(resourceName: "coolicon295"), for: .normal)
                print("no")
            }
        }else{
            presentAlert(title: result.message)
        }
        
    }
    
    func likesForClass(result: classLikeResponse){
        if result.isSuccess{
            likeButton.setImage(#imageLiteral(resourceName: "heart_fill"), for: .selected)
            
            print(likeButton.isSelected)
            print("좋아요")
        }else{
            presentAlert(title: result.message)
        }
        
    }
    
    func dislikesForClass(result: classDislikeResponse){
        if result.isSuccess{
            likeButton.setImage(#imageLiteral(resourceName: "coolicon295"), for: .normal)
            print(likeButton.isSelected)
            print("좋아요취소")
        }else{
            presentAlert(title: result.message)
        }
        
        
    }
    
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
            classInfoForEnrollVC.classTimeList.append(day1 + " / " + startTime1 + " ~ " + endTime1)
            if result.result?.classStartTime2 != nil{
                let day2 = dateToStringOnlyDay(date: stringToDateForDayandDate(dateString: result.result?.classStartTime1 ?? ""))
                let startTime2 = dateToStringOnlyTime(date: stringToDateForDayandDate(dateString: result.result?.classStartTime2 ?? ""))
                let endTime2 = dateToStringOnlyTime(date: stringToDateForDayandDate(dateString: result.result?.classEndTime2 ?? ""))
                classInfoForEnrollVC.classTimeList.append(day2 + " / " + startTime2 + " ~ " + endTime2)
            }
            classInfoForEnrollVC.classPrice = String(result.result?.classPrice ?? -1).insertComma+"원"
            classInfoForEnrollVC.priceOnlyNum = result.result?.classPrice ?? -1
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
        }else{
            presentAlert(title: result.message)
        }
        
        
    }
    
    func failedToRequest(){
        
        self.presentAlert(title: "서버와의 연결이 원활하지 않습니다")
    
    }
    
    
}
