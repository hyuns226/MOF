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
    
    var classTimeList : [classTime] = []
        
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
        
        dataManager.getDetailRegularClasses(classIdx: classIdx, delegate: self)
        
        AskButton.layer.cornerRadius = 18
        registerButton.layer.cornerRadius = 18
            
        //setting Likes Button
        dataManager.getClassLikes(userIdx: KeyCenter.userIndex, classIdx: classIdx, delegate: self)
        
        classTimeCollectionView.delegate = self
        classTimeCollectionView.dataSource = self
        
        
        
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

        
        classPersonnelLabel.text = result.result?.classPersonnel
        classIntroLabel.text = result.result?.classIntro
        
        
       
        
        
        if let url = URL(string: result.result?.teacherImgUrl ?? "") {
            teacherImageView.kf.setImage(with: url)
        } else {
            teacherImageView.image = UIImage(named: "defaultImage")
        }
       
        teacherNameLabel.text = result.result?.classTeacherName
        teacherIntroLabel.text = result.result?.classTeacherIntro
        
    }
    
    
    func failedToRequest(){
        
        self.presentAlert(title: "서버와의 연결이 원활하지 않습니다")
    
    }
    
    
}
