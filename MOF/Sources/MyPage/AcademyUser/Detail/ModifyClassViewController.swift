//
//  modifyClassViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/03/01.
//

import Foundation
import UIKit
class ModifyClassViewController : UIViewController{
    
    var classType = ""
    var classIdx = -1
    var delegate : addClassAlertProtocol?
  
    
    var startTime = ""
    var endTime = ""
    
   
    
    static var regularClassInfo = detailRegularClassResults(classIdx: -1, classImageUrl: "", className: "", classPrice: 0, classPersonnel: 0, classType: "", classStartTime1: "", classEndTime1: "", classStartTime2: "", classEndTime2: "", classIntro: "", teacherImgUrl: "", classTeacherName: "", classTeacherIntro: "", classGernre: "")
    
    static var onedayClassInfo = detailOnedayClassResults(classIdx: -1, classImageUrl: "", className: "", classPrice: 0, classPersonnel: 0, classType: "", classStartTime1: "", classEndTime1: "", classIntro: "", teacherImgUrl: "", classTeacherName: "", classTeacherIntro: "", classGernre: "")
    
    
    var classInput = modifyClassRequest(className: "", classType: "", classPrice: 0, classGernre: "", classPersonnel: 0, classIntro: "", classTeacherName: "", classTeacherIntro: "", classStartTime1: "", classEndTime1: "", classStartTime2: "", classEndTime2: "", classImgUrl: "", teacherImgUrl: "")
    
    var teacherInfoForSend = teacherInfo(image: "", name: "", intro: "")
        
    var teacherImageInput = UIImage()
    var classImageInput = UIImage()
    
    let picker = UIImagePickerController()
   
    var dataManager = AcademyMyPageDataManager()
    
    lazy var buttonList = [kpopButton,coreoButton,hiphopButton,girlsHiphopButton,waakingButton,popinButton,rockingButton,crumpButton,voguingButton,houseButton]
    
    
    @IBOutlet weak var regularClassButton: UIButton!
    @IBOutlet weak var ondayClassButton: UIButton!
    @IBOutlet weak var classNameTextField: UITextField!
    @IBOutlet weak var classExplainTextView: UITextView!
    @IBOutlet weak var TuitionTextView: UITextField!
    @IBOutlet weak var classMemberNumTextField: UITextField!
    @IBOutlet weak var classStartTimeOneButton: UIButton!
    @IBOutlet weak var classEndTimeOneButton: UIButton!
    @IBOutlet weak var classStartTimeTwoButton: UIButton!
    @IBOutlet weak var classEndTimeTwoButton: UIButton!
    @IBOutlet weak var waveLabel: UILabel!
   
    @IBOutlet weak var teacherImageView: UIImageView!
    @IBOutlet weak var addTeacherButton: UIButton!
    @IBOutlet weak var deleteTeacherButton:
        UIButton!
    @IBOutlet weak var classPictureImageView: UIImageView!
    @IBOutlet weak var classPictureDeleteButton: UIButton!
    @IBOutlet weak var classPictureAddButton: UIButton!
    
    @IBOutlet weak var kpopButton: UIButton!
    @IBOutlet weak var coreoButton: UIButton!
    @IBOutlet weak var hiphopButton: UIButton!
    @IBOutlet weak var girlsHiphopButton: UIButton!
    @IBOutlet weak var waakingButton: UIButton!
    @IBOutlet weak var popinButton: UIButton!
    @IBOutlet weak var rockingButton: UIButton!
    @IBOutlet weak var crumpButton: UIButton!
    @IBOutlet weak var voguingButton: UIButton!
    @IBOutlet weak var houseButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonLayout()
        picker.delegate = self
        if classType == "oneday"{
            setOnedayClassInfo()
            print("셋팅된 원데이정보: \(ModifyClassViewController.onedayClassInfo)" )
        }else{
            setRegularClass()
            print("셋팅된 정규정보: \(ModifyClassViewController.regularClassInfo)")
        }
        
        
    }
    
    //MARK:- FUNCTION
    func setButtonLayout(){
        
        regularClassButton.layer.cornerRadius = 25
        regularClassButton.layer.borderWidth = 1
        regularClassButton.layer.borderColor = #colorLiteral(red: 0.737254902, green: 0.737254902, blue: 0.737254902, alpha: 1)
        
        ondayClassButton.layer.cornerRadius = 25
        ondayClassButton.layer.borderWidth = 1
        ondayClassButton.layer.borderColor = #colorLiteral(red: 0.737254902, green: 0.737254902, blue: 0.737254902, alpha: 1)
        
        classStartTimeOneButton.layer.borderWidth = 1
        classStartTimeOneButton.layer.borderColor = #colorLiteral(red: 0.737254902, green: 0.737254902, blue: 0.737254902, alpha: 1)
        
        classEndTimeOneButton.layer.borderWidth = 1
        classEndTimeOneButton.layer.borderColor = #colorLiteral(red: 0.737254902, green: 0.737254902, blue: 0.737254902, alpha: 1)
        
        classStartTimeTwoButton.layer.borderWidth = 1
        classStartTimeTwoButton.layer.borderColor = #colorLiteral(red: 0.737254902, green: 0.737254902, blue: 0.737254902, alpha: 1)
        
        classEndTimeTwoButton.layer.borderWidth = 1
        classEndTimeTwoButton.layer.borderColor = #colorLiteral(red: 0.737254902, green: 0.737254902, blue: 0.737254902, alpha: 1)
        
        for i in buttonList{
            i!.layer.cornerRadius = 20
            i!.layer.borderWidth = 1
            i!.layer.borderColor = #colorLiteral(red: 0.737254902, green: 0.737254902, blue: 0.737254902, alpha: 1)
            i!.setTitleColor(#colorLiteral(red: 0.3646711111, green: 0.3647280335, blue: 0.3646586537, alpha: 1), for: .normal)
                  
            
        }
    
       
    
        
    }
    
    func setOnedayClassInfo(){
        
        classIdx = ModifyClassViewController.onedayClassInfo.classIdx
        
        ondayClassButton.layer.borderColor = #colorLiteral(red: 0.9450980392, green: 0.0862745098, blue: 0.6862745098, alpha: 1)
        ondayClassButton.setTitleColor(#colorLiteral(red: 0.9450980392, green: 0.0862745098, blue: 0.6862745098, alpha: 1), for: .normal)
        classNameTextField.text = ModifyClassViewController.onedayClassInfo.className
        classExplainTextView.text = ModifyClassViewController.onedayClassInfo.classIntro
        TuitionTextView.text = String(ModifyClassViewController.onedayClassInfo.classPrice ?? -1)
        classMemberNumTextField.text = String(ModifyClassViewController.onedayClassInfo.classPersonnel ?? 0)
        classStartTimeOneButton.setTitle(ModifyClassViewController.onedayClassInfo.classStartTime1, for: .normal)
        classEndTimeOneButton.setTitle(ModifyClassViewController.onedayClassInfo.classEndTime1, for: .normal)
        
        if let url = URL(string: ModifyClassViewController.onedayClassInfo.teacherImgUrl ?? "") {
            teacherImageView.kf.setImage(with: url)
        } else {
            teacherImageView.image = UIImage(named: "defaultImage")
        }
        
        if let url = URL(string: ModifyClassViewController.onedayClassInfo.classImageUrl ?? "") {
            classPictureImageView.kf.setImage(with: url)
        } else {
            classPictureImageView.image = UIImage(named: "defaultImage")
        }
        
        let genreIdx = Constant.GenreList.index(of: ModifyClassViewController.onedayClassInfo.classGernre)
        buttonList[genreIdx ?? 0]?.isSelected = true
        buttonList[genreIdx ?? 0]?.layer.borderColor = #colorLiteral(red: 0.9450980392, green: 0.0862745098, blue: 0.6862745098, alpha: 1)
        buttonList[genreIdx ?? 0]?.setTitleColor(#colorLiteral(red: 0.9450980392, green: 0.0862745098, blue: 0.6862745098, alpha: 1), for: .selected)
    
        teacherInfoForSend.image = ModifyClassViewController.onedayClassInfo.teacherImgUrl ?? ""
        teacherInfoForSend.name = ModifyClassViewController.onedayClassInfo.classTeacherName ?? ""
        teacherInfoForSend.intro = ModifyClassViewController.onedayClassInfo.classTeacherIntro ?? ""
        
        //setting modify input
        classInput.className = ModifyClassViewController.onedayClassInfo.className
        classInput.classType = ModifyClassViewController.onedayClassInfo.classType
        classInput.classPrice = ModifyClassViewController.onedayClassInfo.classPrice ?? 0
        classInput.classGernre = ModifyClassViewController.onedayClassInfo.classGernre
        classInput.classPersonnel = ModifyClassViewController.onedayClassInfo.classPersonnel ?? 0
        classInput.classIntro = ModifyClassViewController.onedayClassInfo.classIntro
        classInput.classTeacherName = ModifyClassViewController.onedayClassInfo.classTeacherName ?? ""
        classInput.classTeacherIntro = ModifyClassViewController.onedayClassInfo.classTeacherIntro ?? ""
        classInput.classStartTime1 = ModifyClassViewController.onedayClassInfo.classStartTime1
        classInput.classEndTime1 = ModifyClassViewController.onedayClassInfo.classEndTime1
        classInput.classImgUrl = ModifyClassViewController.onedayClassInfo.classImageUrl ?? ""
        classInput.teacherImgUrl = ModifyClassViewController.onedayClassInfo.teacherImgUrl ?? ""
        
    }
    
    func setRegularClass(){
        
        classIdx = ModifyClassViewController.regularClassInfo.classIdx
        
        regularClassButton.layer.borderColor = #colorLiteral(red: 0.9450980392, green: 0.0862745098, blue: 0.6862745098, alpha: 1)
        regularClassButton.setTitleColor(#colorLiteral(red: 0.9450980392, green: 0.0862745098, blue: 0.6862745098, alpha: 1), for: .normal)
        classNameTextField.text = ModifyClassViewController.regularClassInfo.className
        classExplainTextView.text = ModifyClassViewController.regularClassInfo.classIntro
        TuitionTextView.text = String(ModifyClassViewController.regularClassInfo.classPrice ?? -1)
        classMemberNumTextField.text = String(ModifyClassViewController.regularClassInfo.classPersonnel ?? 0)
        classStartTimeOneButton.setTitle(ModifyClassViewController.regularClassInfo.classStartTime1, for: .normal)
        classEndTimeOneButton.setTitle(ModifyClassViewController.regularClassInfo.classEndTime1, for: .normal)
        
        if ModifyClassViewController.regularClassInfo.classStartTime2 != nil{
            classStartTimeTwoButton.setTitle(ModifyClassViewController.regularClassInfo.classStartTime1, for: .normal)
            classEndTimeTwoButton.setTitle(ModifyClassViewController.regularClassInfo.classEndTime1, for: .normal)
        }
        
        if let url = URL(string: ModifyClassViewController.regularClassInfo.teacherImgUrl ?? "") {
            teacherImageView.kf.setImage(with: url)
        } else {
            teacherImageView.image = UIImage(named: "defaultImage")
        }
        
        if let url = URL(string: ModifyClassViewController.regularClassInfo.classImageUrl ?? "") {
            classPictureImageView.kf.setImage(with: url)
        } else {
            classPictureImageView.image = UIImage(named: "defaultImage")
        }
        
        let genreIdx = Constant.GenreList.index(of: ModifyClassViewController.regularClassInfo.classGernre)
        buttonList[genreIdx ?? 0]?.isSelected = true
        buttonList[genreIdx ?? 0]?.layer.borderColor = #colorLiteral(red: 0.9450980392, green: 0.0862745098, blue: 0.6862745098, alpha: 1)
        buttonList[genreIdx ?? 0]?.setTitleColor(#colorLiteral(red: 0.9450980392, green: 0.0862745098, blue: 0.6862745098, alpha: 1), for: .selected)
        
        teacherInfoForSend.image = ModifyClassViewController.regularClassInfo.teacherImgUrl ?? ""
        teacherInfoForSend.name = ModifyClassViewController.regularClassInfo.classTeacherName ?? ""
        teacherInfoForSend.intro = ModifyClassViewController.regularClassInfo.classTeacherIntro ?? ""
        
        //setting modify input
        classInput.className = ModifyClassViewController.regularClassInfo.className
        classInput.classType = ModifyClassViewController.regularClassInfo.classType
        classInput.classPrice = ModifyClassViewController.regularClassInfo.classPrice ?? 0
        classInput.classGernre = ModifyClassViewController.regularClassInfo.classGernre
        classInput.classPersonnel = ModifyClassViewController.regularClassInfo.classPersonnel ?? 0
        classInput.classIntro = ModifyClassViewController.regularClassInfo.classIntro
        classInput.classTeacherName = ModifyClassViewController.regularClassInfo.classTeacherName ?? ""
        classInput.classTeacherIntro = ModifyClassViewController.regularClassInfo.classTeacherIntro ?? ""
        classInput.classStartTime1 = ModifyClassViewController.regularClassInfo.classStartTime1
        classInput.classEndTime1 = ModifyClassViewController.regularClassInfo.classEndTime1
        classInput.classStartTime1 = ModifyClassViewController.regularClassInfo.classStartTime2 ?? ""
        classInput.classEndTime1 = ModifyClassViewController.regularClassInfo.classEndTime2 ?? ""
        classInput.classImgUrl = ModifyClassViewController.regularClassInfo.classImageUrl ?? ""
        classInput.teacherImgUrl = ModifyClassViewController.regularClassInfo.teacherImgUrl ?? ""
        
        
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func deleteButtonAction(_ sender: Any) {
        let deleteAlertVC = self.storyboard?.instantiateViewController(withIdentifier: "classDeleteAlertViewController")as!classDeleteAlertViewController
        deleteAlertVC.classIdx = self.classIdx
        self.present(deleteAlertVC, animated: false, completion: nil)
    }
    
    @IBAction func regularClassButtonAction(_ sender: Any) {
        
        
        classStartTimeTwoButton.isHidden = false
        classEndTimeTwoButton.isHidden = false
        waveLabel.isHidden = false
        
        regularClassButton.layer.borderColor = #colorLiteral(red: 0.9450980392, green: 0.0862745098, blue: 0.6862745098, alpha: 1)
        regularClassButton.setTitleColor(#colorLiteral(red: 0.9450980392, green: 0.0862745098, blue: 0.6862745098, alpha: 1), for: .normal)
        
        ondayClassButton.layer.borderColor = #colorLiteral(red: 0.737254902, green: 0.737254902, blue: 0.737254902, alpha: 1)
        ondayClassButton.setTitleColor(#colorLiteral(red: 0.3646711111, green: 0.3647280335, blue: 0.3646586537, alpha: 1), for: .normal)
        
        classInput.classType = "Regular"
        classInput.classStartTime1  = ""
        classInput.classEndTime1 = ""
        classInput.classStartTime2 = ""
        classInput.classEndTime2 = ""
        
        classStartTimeOneButton.setTitle("시작시간", for: .normal)
        classEndTimeOneButton.setTitle("종료시간", for: .normal)
        classStartTimeTwoButton.setTitle("시작시간", for: .normal)
        classEndTimeTwoButton.setTitle("종료시간", for: .normal)
        
    }
    
    @IBAction func onedayClassButtonAction(_ sender: Any) {
        classStartTimeTwoButton.isHidden = true
        classEndTimeTwoButton.isHidden = true
        waveLabel.isHidden = true
        
        ondayClassButton.layer.borderColor = #colorLiteral(red: 0.9450980392, green: 0.0862745098, blue: 0.6862745098, alpha: 1)
        ondayClassButton.setTitleColor(#colorLiteral(red: 0.9450980392, green: 0.0862745098, blue: 0.6862745098, alpha: 1), for: .normal)
        
        regularClassButton.layer.borderColor = #colorLiteral(red: 0.737254902, green: 0.737254902, blue: 0.737254902, alpha: 1)
        regularClassButton.setTitleColor(#colorLiteral(red: 0.3646711111, green: 0.3647280335, blue: 0.3646586537, alpha: 1), for: .normal)
        
        classInput.classType = "OneDay"
        classInput.classStartTime1  = ""
        classInput.classEndTime1 = ""
        classInput.classStartTime2 = ""
        classInput.classEndTime2 = ""
        
        classStartTimeOneButton.setTitle("시작시간", for: .normal)
        classEndTimeOneButton.setTitle("종료시간", for: .normal)
        classStartTimeTwoButton.setTitle("시작시간", for: .normal)
        classEndTimeTwoButton.setTitle("종료시간", for: .normal)
        
        
    }
    
    @IBAction func startTimeOneAction(_ sender: Any) {
        
        if classInput.classType == "OneDay"{
            let datePickerVC = self.storyboard?.instantiateViewController(identifier: "datePickerForOnedayPopupViewController") as! datePickerForOnedayPopupViewController
            datePickerVC.delegate = self
          
           
            self.present(datePickerVC, animated: false, completion: nil)
        }else{
            let datePickerVC = self.storyboard?.instantiateViewController(identifier: "datePickerPopUpViewController") as! datePickerPopUpViewController
            datePickerVC.delegate = self
            datePickerVC.dateLabel = "one"
           
            self.present(datePickerVC, animated: false, completion: nil)
        }
        
        
    }
    @IBAction func startTimeTwoAction(_ sender: Any) {
        let datePickerVC = self.storyboard?.instantiateViewController(identifier: "datePickerPopUpViewController") as! datePickerPopUpViewController
        datePickerVC.delegate2 = self
        datePickerVC.dateLabel = "two"
       
        self.present(datePickerVC, animated: false, completion: nil)
    }
   
    
    @IBAction func addTeacherButtonAction(_ sender: Any) {
        let addTeacherPopUp = self.storyboard?.instantiateViewController(identifier: "ModifyTeacherPopupViewController") as! ModifyTeacherPopupViewController
        addTeacherPopUp.delegate = self
        addTeacherPopUp.teacherInfomation = self.teacherInfoForSend
        self.present(addTeacherPopUp, animated: false, completion: nil)
    }
    @IBAction func deleteTeacherButtonAction(_ sender: Any) {
    }
    
    @IBAction func deleteClassPicture(_ sender: Any) {
    }
    
    @IBAction func addClassPicture(_ sender: Any) {
        openlibrary()
        
    }
    
    func openlibrary(){
        picker.sourceType = .photoLibrary
        picker.modalPresentationStyle = .fullScreen
        present(picker, animated: true)
        
    }
    
    //강의 장르 버튼 선택 동작
    @IBAction func genreButtonAction(_ sender: UIButton) {
        switch sender.tag{
        case 1 :
           
            GenrebuttonClicked(index : sender.tag-1)
            
            break
        case 2 :
            GenrebuttonClicked(index : sender.tag-1)
            break
         
        case 3 :
            GenrebuttonClicked(index : sender.tag-1)
            break
        case 4 :
            GenrebuttonClicked(index : sender.tag-1)
            break
        case 5 :
            GenrebuttonClicked(index : sender.tag-1)
            break
        case 6 :
            GenrebuttonClicked(index : sender.tag-1)
            break
        case 7 :
            GenrebuttonClicked(index : sender.tag-1)
            break
        case 8 :
            GenrebuttonClicked(index : sender.tag-1)
            break
        case 9 :
            GenrebuttonClicked(index : sender.tag-1)
            break
        case 10:
            GenrebuttonClicked(index : sender.tag-1)
            break
        default:
            print("")
        
            }
        }
    
    
   func GenrebuttonClicked(index : Int){
            let temp = buttonList
            buttonList.remove(at: index)
            
            for i in buttonList{
                i!.layer.borderColor = #colorLiteral(red: 0.737254902, green: 0.737254902, blue: 0.737254902, alpha: 1)
                i!.isSelected = false
                i!.setTitleColor(#colorLiteral(red: 0.3646711111, green: 0.3647280335, blue: 0.3646586537, alpha: 1), for: .normal)
            }
            
            buttonList = temp
            
    buttonList[index]!.isSelected = true
            buttonList[index]!.layer.borderColor = #colorLiteral(red: 1, green: 0, blue: 0.7033678889, alpha: 1)
            buttonList[index]!.setTitleColor(#colorLiteral(red: 1, green: 0, blue: 0.7033678889, alpha: 1), for: .selected)
            
    classInput.classGernre = Constant.GenreList[index]
            print(classInput.classGernre)
            
        }
            
           
    @IBAction func addClassButtonAction(_ sender: Any) {
     
        classInput.className = classNameTextField.text!
        classInput.classPrice = Int(TuitionTextView.text!) ?? 0
        classInput.classPersonnel = Int(classMemberNumTextField.text!) ?? 0
        classInput.classIntro = classExplainTextView.text!
      
        print(teacherImageInput,
              classImageInput)
        print(teacherImageInput.size.width)
        print(classImageInput.size.width)
        print(classInput)
        
        //새로운 이미지 선택했으면 backimage url 삭제
        if teacherImageInput.size.width != 0.0{
            classInput.classImgUrl = ""
        }
        
        if teacherImageInput.size.width != 0.0{
            classInput.teacherImgUrl = ""
        }
       
        dataManager.modifyClass(parameters: classInput, classImage: classImageInput, teacherImage: teacherImageInput, academyIdx: KeyCenter.userIndex, classIdx: self.classIdx, delegate: self)
        
    }
    
}

extension ModifyClassViewController : UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    func imagePickerController(_ picker : UIImagePickerController, didFinishPickingMediaWithInfo info : [UIImagePickerController.InfoKey : Any]){
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
        
            classPictureImageView.image = image
            classImageInput = image
            self.dismiss(animated: true, completion: nil)
            
        }
    
    }
}

//MARK:- Protocol

extension ModifyClassViewController : selectedDateProtocol, selectedDateProtocol2,selectedOnedayDateProtocol,teacherInfoProtocol{
    
    func sendDate(startDateForShow : String, startDateForSend : String,  endDateForShow : String, endDateForSend : String){
        
        classStartTimeOneButton.setTitle(startDateForShow, for: .normal)
        classEndTimeOneButton.setTitle(endDateForShow, for: .normal)
        
        classInput.classStartTime1 = startDateForSend
        classInput.classEndTime1 = endDateForSend
        print(startDateForSend,endDateForSend)
       
    }
    
    func sendDate2(startDateForShow: String, startDateForSend: String, endDateForShow: String, endDateForSend: String) {
        classStartTimeTwoButton.setTitle(startDateForShow, for: .normal)
        classEndTimeTwoButton.setTitle(endDateForShow, for: .normal)
        
        classInput.classStartTime2 = startDateForSend
        classInput.classEndTime2 = endDateForSend
        print(startDateForSend,endDateForSend)
    }
    
    func sendonedayDate(startDateForShow: String, startDateForSend: String, endDateForShow: String, endDateForSend: String) {
        classStartTimeOneButton.setTitle(startDateForShow, for: .normal)
        classEndTimeOneButton.setTitle(endDateForShow, for: .normal)
        
        classInput.classStartTime1 = startDateForSend
        classInput.classEndTime1 = endDateForSend
        print(startDateForSend,endDateForSend)
        
    }
    
    func sendTeacherInfo(teacherImage: UIImage, teacherName: String, teacherIntro: String) {
        teacherImageInput = teacherImage
        teacherImageView.image = teacherImage
        classInput.classTeacherName = teacherName
        classInput.classTeacherIntro = teacherIntro
         

    }
    
    
}

//MARK:- API
extension ModifyClassViewController{
    
    func addClass(result : addClassResponse){
        print(result)
        if result.isSuccess{
            delegate?.showAlert()
            self.dismiss(animated: true, completion: nil)
            
            
        }else{
            presentAlert(title: result.message)
          
        }
    }
    
    func modifyClass(result : modifyClassResponse){
        if result.isSuccess{
            print(result)
            self.dismiss(animated: true, completion: nil)
            
            
        }else{
            presentAlert(title: result.message)
          
        }
    }
    
    func failedToRequest(){
        
        self.presentAlert(title: "서버와의 연결이 원활하지 않습니다")
    
    }
    
    
}
