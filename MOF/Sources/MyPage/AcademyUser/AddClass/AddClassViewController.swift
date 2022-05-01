//
//  AddClassViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/01/06.
//

import UIKit
import PhotosUI
class AddClassViewController : UIViewController{
    
    var delegate : addClassAlertProtocol?
    
    var startTime = ""
    var endTime = ""
    
    var clickedGenre = ""
    var classType = ""
    var classInput = addClassRequest(className: "", classType: "", classPrice: 0, classGernre: "", classPersonnel: 0, classIntro: "", classTeacherName: "", classTeacherIntro: "", classStartTime1: "", classEndTime1: "", classStartTime2: "", classEndTime2: "")
    
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
    
    @IBOutlet weak var addClassButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonLayout()
        picker.delegate = self
        dismissKeyboardWhenTappedAround()
        addClassButton.layer.cornerRadius = 17.5
       
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
    
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func regularClassButtonAction(_ sender: Any) {
        
        
        classStartTimeTwoButton.isHidden = false
        classEndTimeTwoButton.isHidden = false
        waveLabel.isHidden = false
        
        regularClassButton.layer.borderColor = #colorLiteral(red: 0.9450980392, green: 0.0862745098, blue: 0.6862745098, alpha: 1)
        regularClassButton.setTitleColor(#colorLiteral(red: 0.9450980392, green: 0.0862745098, blue: 0.6862745098, alpha: 1), for: .normal)
        
        ondayClassButton.layer.borderColor = #colorLiteral(red: 0.737254902, green: 0.737254902, blue: 0.737254902, alpha: 1)
        ondayClassButton.setTitleColor(#colorLiteral(red: 0.3646711111, green: 0.3647280335, blue: 0.3646586537, alpha: 1), for: .normal)
        
        self.classType = "Regular"
        classInput.classStartTime1  = ""
        classInput.classEndTime1 = ""
        classInput.classStartTime2 = ""
        classInput.classEndTime2 = ""
        
        classStartTimeOneButton.setTitle("시작 시간", for: .normal)
        classEndTimeOneButton.setTitle("종료 시간", for: .normal)
        classStartTimeTwoButton.setTitle("시작 시간", for: .normal)
        classEndTimeTwoButton.setTitle("종료 시간", for: .normal)
        
    }
    
    @IBAction func onedayClassButtonAction(_ sender: Any) {
        classStartTimeTwoButton.isHidden = true
        classEndTimeTwoButton.isHidden = true
        waveLabel.isHidden = true
        
        ondayClassButton.layer.borderColor = #colorLiteral(red: 0.9450980392, green: 0.0862745098, blue: 0.6862745098, alpha: 1)
        ondayClassButton.setTitleColor(#colorLiteral(red: 0.9450980392, green: 0.0862745098, blue: 0.6862745098, alpha: 1), for: .normal)
        
        regularClassButton.layer.borderColor = #colorLiteral(red: 0.737254902, green: 0.737254902, blue: 0.737254902, alpha: 1)
        regularClassButton.setTitleColor(#colorLiteral(red: 0.3646711111, green: 0.3647280335, blue: 0.3646586537, alpha: 1), for: .normal)
        
        self.classType = "OneDay"
        classInput.classStartTime1  = ""
        classInput.classEndTime1 = ""
        classInput.classStartTime2 = ""
        classInput.classEndTime2 = ""
        
        classStartTimeOneButton.setTitle("시작 시간", for: .normal)
        classEndTimeOneButton.setTitle("종료 시간", for: .normal)
        classStartTimeTwoButton.setTitle("시작 시간", for: .normal)
        classEndTimeTwoButton.setTitle("종료 시간", for: .normal)
        
        
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
        let addTeacherPopUp = self.storyboard?.instantiateViewController(identifier: "AddTeacherPopUpViewController") as! AddTeacherPopUpViewController
        addTeacherPopUp.delegate = self
        self.present(addTeacherPopUp, animated: false, completion: nil)
    }
    @IBAction func deleteTeacherButtonAction(_ sender: Any) {
    }
    
    @IBAction func deleteClassPicture(_ sender: Any) {
    }
    
    @IBAction func addClassPicture(_ sender: Any) {
        if #available(iOS 14, *) {
            if PHPhotoLibrary.authorizationStatus() == .authorized || PHPhotoLibrary.authorizationStatus() == .limited {
                //1. 허용된 상태
                DispatchQueue.main.async {
                    self.openlibrary()
                }
            }else if PHPhotoLibrary.authorizationStatus() == .denied{
                //2. 허용안된 상태
                DispatchQueue.main.async {
                    self.showAuthorizationAlert()
                }
            } else if PHPhotoLibrary.authorizationStatus() == .notDetermined{
                //3. notdetermined: 물어보지 않은 상태
                //info.plist에서 설정
                PHPhotoLibrary.requestAuthorization { status in
                    //클로저 상태안에서 호출하면 쓰레드가 하나 생기는데 이쓰레드에서 checkPermission 호출하면 오류가 난다 그래서 dispatchqueue.main.async로 해야된다
                  
                }
                
            }
        } else {
            // Fallback on earlier versions
        }
        
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
                i!.setTitleColor(#colorLiteral(red: 0.3646711111, green: 0.3647280335, blue: 0.3646586537, alpha: 1), for: .normal)
            }
            
            buttonList = temp
            
            buttonList[index]!.layer.borderColor = #colorLiteral(red: 1, green: 0, blue: 0.7033678889, alpha: 1)
            buttonList[index]!.setTitleColor(#colorLiteral(red: 1, green: 0, blue: 0.7033678889, alpha: 1), for: .normal)
            
            clickedGenre = Constant.GenreList[index]
            print(clickedGenre)
            
        }
            
           
    @IBAction func addClassButtonAction(_ sender: Any) {
    
        if classNameTextField.text != "" && classExplainTextView.text != "" && TuitionTextView.text != "" && classMemberNumTextField.text != "" &&  classStartTimeOneButton.titleLabel!.text! != "시작 시간" && classEndTimeOneButton.titleLabel!.text! != "종료 시간" && clickedGenre != "" && classType != ""{
            
            
            classInput.classType = self.classType
            classInput.className = classNameTextField.text!
            classInput.classPrice = Int(TuitionTextView.text!) ?? 0
            classInput.classGernre = clickedGenre
            classInput.classPersonnel = Int(classMemberNumTextField.text!) ?? 0
            classInput.classIntro = classExplainTextView.text!
            
          
            print(teacherImageInput,
                  classImageInput)
         
            print(teacherImageInput.size.width)
            print(classImageInput.size.width)
            print(classInput)
           
            dataManager.addClass(parameters: classInput, classImage: classImageInput, teacherImage: teacherImageInput,academyIdx : KeyCenter.userIndex, delegate: self)
            
        }else{
            presentAlert(title: "필수 정보를 모두 작성해주세요")
        }
       
    }
    
}

extension AddClassViewController : UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    func imagePickerController(_ picker : UIImagePickerController, didFinishPickingMediaWithInfo info : [UIImagePickerController.InfoKey : Any]){
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
        
            classPictureImageView.image = image
            classImageInput = image
            self.dismiss(animated: true, completion: nil)
            
        }
    
    }
}

//MARK:- Protocol

extension AddClassViewController : selectedDateProtocol, selectedDateProtocol2,selectedOnedayDateProtocol,teacherInfoProtocol{
    
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
extension AddClassViewController{
    
    func addClass(result : addClassResponse){
        print(result)
        if result.isSuccess{
            delegate?.showAlert()
            self.dismiss(animated: true, completion: nil)
            
            
        }else{
            presentAlert(title: result.message)
          
        }
    }
    
    func failedToRequest(){
        
        self.presentAlert(title: "서버와의 연결이 원활하지 않습니다")
    
    }
    
    
}
