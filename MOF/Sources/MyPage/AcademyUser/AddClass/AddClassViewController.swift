//
//  AddClassViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/01/06.
//

import UIKit
class AddClassViewController : UIViewController{
    
    var startTime = ""
    var endTime = ""
    
    var clickedGenre = ""
    var genreList = ["K-POP","코레오","힙합","걸스힙합","왁킹","팝핀","락킹","크럼프","보깅","하우스"]
    
    var classInput = addClassRequest(classPicture: "", teacher: "", className: "", classType: "", classPrice: 0, classGernre: "", classPersonnel: 0, classIntro: "", classTeacherName: "", classTeacherIntro: "", classStartTime1: "", classEndTime1: "", classStartTime2: "", classEndTime2: "")
  
   
    
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
    @IBOutlet weak var teacherCollectionView: UICollectionView!
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
    
    @IBAction func regularClassButtonAction(_ sender: Any) {
        
        
        classStartTimeTwoButton.isHidden = false
        classEndTimeTwoButton.isHidden = false
        waveLabel.isHidden = false
        
        regularClassButton.layer.borderColor = #colorLiteral(red: 0.9450980392, green: 0.0862745098, blue: 0.6862745098, alpha: 1)
        regularClassButton.setTitleColor(#colorLiteral(red: 0.9450980392, green: 0.0862745098, blue: 0.6862745098, alpha: 1), for: .normal)
        
        ondayClassButton.layer.borderColor = #colorLiteral(red: 0.737254902, green: 0.737254902, blue: 0.737254902, alpha: 1)
        ondayClassButton.setTitleColor(#colorLiteral(red: 0.3646711111, green: 0.3647280335, blue: 0.3646586537, alpha: 1), for: .normal)
        
        classInput.classType = "Regular"
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
    }
    
    @IBAction func startTimeOneAction(_ sender: Any) {
        
        let datePickerVC = self.storyboard?.instantiateViewController(identifier: "datePickerPopUpViewController") as! datePickerPopUpViewController
        
       
        self.present(datePickerVC, animated: false, completion: nil)
        
    }
    @IBAction func endTimeTwoAction(_ sender: Any) {
    }
    @IBAction func EndTimeOneAction(_ sender: Any) {
    }
    @IBAction func startTimeTwoAction(_ sender: Any) {
    }
    
    @IBAction func addTeacherButtonAction(_ sender: Any) {
        
        let addTeacherPopUp = self.storyboard?.instantiateViewController(identifier: "AddTeacherPopUpViewController") as! AddTeacherPopUpViewController
        
        self.present(addTeacherPopUp, animated: false, completion: nil)
        
        
        
    }
    
    @IBAction func deleteClassPicture(_ sender: Any) {
    }
    
    @IBAction func addClassPicture(_ sender: Any) {
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
            
            clickedGenre = genreList[index]
            print(clickedGenre)
            
        }
            
           
    @IBAction func addClassButtonAction(_ sender: Any) {
        
        classInput.classPicture = ""
        classInput.teacher = ""
        classInput.className = classNameTextField.text!
        classInput.classPrice = Int(TuitionTextView.text!) ?? 0
        classInput.classGernre = clickedGenre
        classInput.classPersonnel = Int(classMemberNumTextField.text!) ?? 0
        classInput.classIntro = classExplainTextView.text!
        classInput.classTeacherName = ""
        classInput.classTeacherIntro = ""
        classInput.classStartTime1 = ""
        classInput.classEndTime1 = ""
        classInput.classStartTime2 = ""
        classInput.classEndTime2 = ""
       
        
    }
}