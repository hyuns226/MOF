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
  
    @IBOutlet weak var likeButton: UIButton!
    
    
    @IBOutlet weak var imageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var stackViewHeight: NSLayoutConstraint!
    @IBOutlet weak var regularClassTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var onedayClassTableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var collectionViewHeight: NSLayoutConstraint!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!
    
    
        
       override func viewDidLoad() {
        super.viewDidLoad()
        
        //네비게이션 hidden상태에서 뒤로가기 제스쳐
        self.navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        print(AcademyInfo)
        
        settingCollectionView()
        settingButton()
        
        //setting Academy information
        if let url = URL(string: AcademyInfo.academyImage ?? "") {
            academyImageView.kf.setImage(with: url)
        } else {
            academyImageView.image = UIImage(named: "defaultImage")
        }
        academyNameLabel.text = AcademyInfo.academyName
        academyPhoneLabel.text = AcademyInfo.academyPhoneNum.hyphen()
        academyAddressLabel.text = AcademyInfo.academyAddress
    
        
        print(AcademyInfo)
          
        
               self.dataManager.academyRegularClass(academyIdx: self.AcademyInfo.academyIdx, delegate: self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
       
        //change status bar color to light
        UIApplication.shared.statusBarStyle = .lightContent
        navigationController?.setNavigationBarHidden(true, animated: animated)
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
        if #available(iOS 15.0, *) {
            regularClassTableView.sectionHeaderTopPadding = 0
            OnedayClassTableView.sectionHeaderTopPadding = 0
        }
        
    }
    
    func settingButton(){
        //setting button layout
        AskButton.layer.cornerRadius = 18
       
        
        //setting Likes Button
        if KeyCenter.userType == "general"{
            dataManager.getAcademyLikes(userIdx: KeyCenter.userIndex, academyIdx: AcademyInfo.academyIdx, delegate: self)
        }else{
            likeButton.isHidden = true
        }
        
    
    }
  
    
    @IBAction func likeButtonAction(_ sender: Any) {
        likeButton.isSelected =  !likeButton.isSelected
      
        if likeButton.isSelected == true{
            dataManager.likesForAcademy(userIdx: KeyCenter.userIndex, academyIdx: AcademyInfo.academyIdx, delegate: self)
            
            
        }else{
            dataManager.dislikesForAcademy(userIdx: KeyCenter.userIndex, academyIdx: AcademyInfo.academyIdx, delegate: self)
            
        }
    }
    
    
    @IBAction func nofityButtonAction(_ sender: Any) {
        presentAlert(title: "신고가 정상적으로 접수되었습니다")
    }
    
    @IBAction func askButtonAction(_ sender: Any) {
        print(Int(AcademyInfo.academyPhoneNum))
        print(AcademyInfo.academyPhoneNum)
        let number : Int = Int(AcademyInfo.academyPhoneNum) ?? 0
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
            
          
                print(4)
                
           
            
                
              
            
           
           
            
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == regularClassTableView{
            let classDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "ClassDetailViewController")as!ClassDetailViewController
            classDetailVC.classIdx = regularClassResultList[indexPath.section].classIdx
            classDetailVC.classType = "Regular"
            classDetailVC.academyPhoneNum = AcademyInfo.academyPhoneNum
            self.navigationController?.pushViewController(classDetailVC, animated: true)
            
        }else{
            let classDetailVC = self.storyboard?.instantiateViewController(withIdentifier: "ClassDetailViewController")as!ClassDetailViewController
            classDetailVC.classIdx = onedayClassResultList[indexPath.section].classIdx
            classDetailVC.classType = "OneDay"
            classDetailVC.academyPhoneNum = AcademyInfo.academyPhoneNum
            self.navigationController?.pushViewController(classDetailVC, animated: true)
            
        }
    }

    // MARK: - Table View delegate methods

        func numberOfSections(in tableView: UITableView) -> Int {
            if tableView == regularClassTableView{
                
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
            
            print(6)
            regularClassTableView.reloadData()
            print(9)
            
           
            
            print(7)
            if regularClassResultList.count == 0{
                regularClassTableViewHeight.constant = 0
            }
            
           
           
            self.dataManager.academyOnedayClass(academyIdx: self.AcademyInfo.academyIdx, delegate: self)
           
            
            
            
            
        }else{
            presentAlert(title:  result.message)
        }
    }
    
    func academyOnedayClass(result : academyOnedayResponse){
        if result.isSuccess{
            print(result)
            onedayClassResultList = result.result ?? []
            print(8)
            OnedayClassTableView.reloadData()
            
            self.regularClassTableViewHeight.constant = self.regularClassTableView.contentSize.height +  CGFloat(regularClassResultList.count * 10)
        
        
            print("regular contentsize1: \(regularClassTableView.contentSize)")
            print("regular viewheight1: \(regularClassTableViewHeight.constant)")
            
            
            print(5)
            self.onedayClassTableViewHeight.constant = self.OnedayClassTableView.contentSize.height

            print(9)
            if onedayClassResultList.count == 0{
                onedayClassTableViewHeight.constant = 0
            }
            
            
            
         self.viewHeight.constant = self.imageViewHeight.constant + self.stackViewHeight.constant + self.regularClassTableViewHeight.constant + CGFloat(regularClassResultList.count * 10) + self.onedayClassTableViewHeight.constant  + 170
          
            print(imageViewHeight.constant)
            print(stackViewHeight.constant)
            print("regular contentsize: \(regularClassTableView.contentSize)")
            print("regular viewheight: \(regularClassTableViewHeight.constant)")
            print(onedayClassTableViewHeight.constant)
            print(collectionViewHeight.constant)
           
            
        }else{
            presentAlert(title:  result.message)
        }
    }
    
    
    
    func failedToRequest(){
        
        self.presentAlert(title: "서버와의 연결이 원활하지 않습니다")
    
    }
    
    
}

