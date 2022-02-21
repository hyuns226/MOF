//
//  DetaliPageViewController.swift
//  MOF
//
//  Created by 이현서 on 2021/11/16.
//

import UIKit
class AcademyDetaliViewController : UIViewController {
    
    lazy var dataManager = HomeDataManager()
    
   
    var AcademyInfo = detailAcademyInfo(academyIdx: -1, academyImage: "", academyName: "", academyPhoneNum: "", academyAddress: "")
    
    var regularClassResultList : [academyRegularResult] = []
    var onedayClassResultList : [academyOnedayResult] = []
    
    
    @IBOutlet weak var academyImageView: UIImageView!
    @IBOutlet weak var academyNameLabel: UILabel!
    @IBOutlet weak var academyPhoneLabel: UILabel!
    @IBOutlet weak var academyAddressLabel: UILabel!
    
    @IBOutlet weak var regularClassTableView: UITableView!
    @IBOutlet weak var OnedayClassTableView: UITableView!
    
    @IBOutlet weak var OtherClassCollectionView: UICollectionView!
    @IBOutlet weak var AskButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var likeButton: UIButton!
    
    
        
        
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(AcademyInfo)
        
        //setting Academy information
        if let url = URL(string: AcademyInfo.academyImage ?? "") {
            academyImageView.kf.setImage(with: url)
        } else {
            academyImageView.image = UIImage(named: "defaultImage")
        }
        academyNameLabel.text = AcademyInfo.academyName
        academyPhoneLabel.text = AcademyInfo.academyPhoneNum
        academyAddressLabel.text = AcademyInfo.academyAddress
    
        dataManager.academyRegularClass(academyIdx: AcademyInfo.academyIdx, delegate: self)
        dataManager.academyOnedayClass(academyIdx: AcademyInfo.academyIdx, delegate: self)
        
        
        settingCollectionView()
        settingButton()
    }
    
    //MARK:- FUNCTION
    func settingCollectionView(){
        //setting tavleview,collectionview
        regularClassTableView.delegate = self
        regularClassTableView.dataSource = self
        OnedayClassTableView.delegate = self
        OnedayClassTableView.dataSource = self
        OtherClassCollectionView.dataSource = self
        OtherClassCollectionView.delegate = self
        
    }
    
    func settingButton(){
        //setting button layout
        AskButton.layer.cornerRadius = 18
        registerButton.layer.cornerRadius = 18
        
        //setting Likes Button
        dataManager.getAcademyLikes(userIdx: KeyCenter.userIndex, academyIdx: AcademyInfo.academyIdx, delegate: self)
    
    }
    
    @IBAction func likeButtonAction(_ sender: Any) {
        likeButton.isSelected =  !likeButton.isSelected
      
        if likeButton.isSelected == true{
            dataManager.likesForAcademy(userIdx: KeyCenter.userIndex, academyIdx: AcademyInfo.academyIdx, delegate: self)
            
            
        }else{
            dataManager.dislikesForAcademy(userIdx: KeyCenter.userIndex, academyIdx: AcademyInfo.academyIdx, delegate: self)
            
        }
    }
    
}


//MARK:- EXTENSION

extension AcademyDetaliViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell!
        if tableView == regularClassTableView{
             let regularCell = tableView.dequeueReusableCell(withIdentifier: "RegularClassTableViewCell") as! RegularClassTableViewCell
            

            regularCell.classNameLabel.text =  regularClassResultList[indexPath.section].className
            print(regularClassResultList[indexPath.section].className)
            regularCell.teacherNameLabel.text = regularClassResultList[indexPath.section].classTeacherName+" 선생님"
           
            //Set class time
            let startTime1 = dateToString(date: stringToDate(dateString: regularClassResultList[indexPath.section].classStartTime1))
            let endTime1 = dateToString(date: stringToDate(dateString: regularClassResultList[indexPath.section].classEndTime1))
            
            regularCell.classTimeOneLabel.text = startTime1 + " ~ " + endTime1
            
            if regularClassResultList[indexPath.section].classStartTime2 != nil{
                let startTime2 = dateToString(date: stringToDate(dateString: regularClassResultList[indexPath.section].classStartTime2 ?? ""))
                let endTime2 = dateToString(date: stringToDate(dateString: regularClassResultList[indexPath.section].classEndTime2 ?? ""))
                
                regularCell.classTimeTwoLabel.text = startTime2 + " ~ " + endTime2
                
                
            }else{
                
                regularCell.classTimeTwoLabel.isHidden = true
            }
            cell = regularCell
        }else{
            let ondayCell = tableView.dequeueReusableCell(withIdentifier: "OnedayClassTableViewCell") as! OnedayClassTableViewCell
            
            ondayCell.classNameLabel.text = onedayClassResultList[indexPath.section].className
            ondayCell.teacherNameLabel.text = onedayClassResultList[indexPath.section].classTeacherName+" 선생님"
            ondayCell.classTimeOneLabel.text = onedayClassResultList[indexPath.section].classStartTime1 + onedayClassResultList[indexPath.section].classEndTime1
            
            //Set class time
            let startTime1 = dateToString(date: stringToDate(dateString: onedayClassResultList[indexPath.section].classStartTime1))
            let endTime1 = dateToString(date: stringToDate(dateString: onedayClassResultList[indexPath.section].classEndTime1))
            
            ondayCell.classTimeOneLabel.text = startTime1 + " ~ " + endTime1
            
           cell = ondayCell
        }
        
        //cell.layer.cornerRadius = 19
        cell.separatorInset = UIEdgeInsets.zero
        return  cell
    }

    // MARK: - Table View delegate methods

        func numberOfSections(in tableView: UITableView) -> Int {
            if tableView == regularClassTableView{
                print("count : \(regularClassResultList.count)")
                return regularClassResultList.count
            }else{
                return onedayClassResultList.count
            }
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

extension AcademyDetaliViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OtherAcademyCollectionViewCell", for: indexPath)  as! OtherAcademyCollectionViewCell
        
        return cell
         
    }
    
}

//MARK: - API
extension AcademyDetaliViewController{
    
    func getAcademyLikes(result : getAcademyLikesResponse){
        print(result.result.좋아요여부)
        if result.result.좋아요여부 == "YES"{
            self.likeButton.isSelected = true
            self.likeButton.setImage(#imageLiteral(resourceName: "heart_fill"), for: .selected)
            print("yes")
        }else{
            self.likeButton.isSelected = false
            self.likeButton.setImage(#imageLiteral(resourceName: "coolicon295"), for: .normal)
            print("no")
        }
    }
    
    
    func likesForAcademy(result: likeResponse){
        if result.isSuccess{
            likeButton.setImage(#imageLiteral(resourceName: "heart_fill"), for: .selected)
            
            print(likeButton.isSelected)
            print("클릭")
        }else{
            presentAlert(title: result.message)
        }
        
    }
    
    func dislikesForAcademy(result: dislikeResponse){
        if result.isSuccess{
            likeButton.setImage(#imageLiteral(resourceName: "heart"), for: .normal)
            print(likeButton.isSelected)
            print("안클릭")
        }else{
            presentAlert(title: result.message)
        }
        
        
    }
    
    func academyRegularClass(result : academyRegularResponse){
        if result.isSuccess{
            print(result)
            regularClassResultList = result.result ?? []
            regularClassTableView.reloadData()
            
        }else{
            presentAlert(title:  result.message)
        }
    }
    
    func academyOnedayClass(result : academyOnedayResponse){
        if result.isSuccess{
            print(result)
            onedayClassResultList = result.result ?? []
            OnedayClassTableView.reloadData()
            
        }else{
            presentAlert(title:  result.message)
        }
    }
    
    
    
    func failedToRequest(){
        
        self.presentAlert(title: "서버와의 연결이 원활하지 않습니다")
    
    }
    
    
    
}

