//
//  academyMyProfileViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/02/09.
//

import Foundation
import UIKit
class AcademyMyProfileViewController : UIViewController{
    
    lazy var dataManager = AcademyMyPageDataManager()
    
    var clickedAcademyList = [Int]()
    
    var modifyInput = academyProfileRequest(image: nil, academyEmail: "", academyName: "", academyPhone: "", academyAddress: "", academyDetailAddress: "", academyGernre: "", profileImgUrl: "")
    
    var genreInput = [String]()
    var genreString = ""
    
    lazy var buttonList = [kpopButton,coreoButton,hiphopButton,girlsHiphopButton,waakingButton,popinButton,rockingButton,crumpButton,voguingButton,houseButton]
    
    var genreList = ["K-POP","코레오","힙합","걸스힙합","왁킹","팝핀","락킹","크럼프","보깅","하우스"]
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var academyNameTextField: UITextField!
    @IBOutlet weak var phoneNumTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var detailAddressTextField: UITextField!
    
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
    
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        dataManager.academyProfile(academyIdx: KeyCenter.userIndex, delegate: self)
        setButtonLayout()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK:- FUNCTION
    func setButtonLayout(){
        for i in buttonList{
            i!.layer.cornerRadius = 20
            i!.layer.borderWidth = 1
            i!.layer.borderColor = #colorLiteral(red: 0.737254902, green: 0.737254902, blue: 0.737254902, alpha: 1)
            i!.setTitleColor(#colorLiteral(red: 0.3646711111, green: 0.3647280335, blue: 0.3646586537, alpha: 1), for: .normal)
                  
        }
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        
        setGenreInput()
        
        let filteredArray = [emailTextField,academyNameTextField,phoneNumTextField,addressTextField,detailAddressTextField].filter { $0?.text == "" }
        if (filteredArray.isEmpty) && genreString != ""{
            //modifyInput.image =
            modifyInput.academyEmail = emailTextField.text!
            modifyInput.academyName = academyNameTextField.text!
            modifyInput.academyPhone = phoneNumTextField.text!
            modifyInput.academyAddress = addressTextField.text!
            modifyInput.academyDetailAddress = detailAddressTextField.text!
           
            modifyInput.academyGernre = genreString
            print(genreString)
            dataManager.academyProfileModify(modifyInput, academyIdx: KeyCenter.userIndex, delegate: self)
            
        }else{
            
            presentAlert(title: "비어있는 정보가 있습니다. 모든 정보를 작성해주세요")
            
        }
     
        
        
    
        
       
        
       
    }
    
    func setGenreInput(){
        for i in 0...9{
            if clickedAcademyList.contains(i){
                genreInput.append(genreList[i])
            }
        
        }
        
        for i in genreInput{
            
            if genreString == ""{
                genreString = i
            }else{
                genreString = genreString + ", " + i
            }
            
           
        }
        
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
         buttonList[index]!.isSelected = !buttonList[index]!.isSelected
         if buttonList[index]!.isSelected{
            buttonList[index]?.layer.borderColor = #colorLiteral(red: 0.9450980392, green: 0.0862745098, blue: 0.6862745098, alpha: 1)
            buttonList[index]?.setTitleColor(#colorLiteral(red: 0.9450980392, green: 0.0862745098, blue: 0.6862745098, alpha: 1), for: .selected)
            
             clickedAcademyList.append(index)
             clickedAcademyList.sort()
            print(clickedAcademyList)
             
         }else{
            buttonList[index]?.layer.borderColor = #colorLiteral(red: 0.737254902, green: 0.737254902, blue: 0.737254902, alpha: 1)
            buttonList[index]?.setTitleColor(#colorLiteral(red: 0.3646711111, green: 0.3647280335, blue: 0.3646586537, alpha: 1), for: .normal)
            
             clickedAcademyList.removeAll(where: { $0 == index })
            print(clickedAcademyList)
         }
         
     }
    
    
}

//MARK:- API

extension AcademyMyProfileViewController {
    
    func academyProfile(result : academyProfileResponse){
        if result.isSuccess{
            
            emailTextField.text = result.result.academyEmail
            academyNameTextField.text = result.result.academyName
            phoneNumTextField.text = result.result.academyPhone
            addressTextField.text = result.result.academyAddress
            detailAddressTextField.text = result.result.academyDetailAddress
            
           
            //장르 string 잘라서 배열로
            let filterdGenreList = String(result.result.academyGernre.filter { !" ".contains($0) }).components(separatedBy: ",")
            
            //장르 인덱스 저장
            for i in filterdGenreList{
                clickedAcademyList.append(genreList.firstIndex(of: i) ?? 0)
                
            }
           
            for i in filterdGenreList{
                
                let genreIdx = genreList.firstIndex(of: "\(i)")

                buttonList[genreIdx ?? 0]?.isSelected = true
                buttonList[genreIdx ?? 0]?.layer.borderColor = #colorLiteral(red: 0.9450980392, green: 0.0862745098, blue: 0.6862745098, alpha: 1)
                buttonList[genreIdx ?? 0]?.setTitleColor(#colorLiteral(red: 0.9450980392, green: 0.0862745098, blue: 0.6862745098, alpha: 1), for: .selected)
                
            }
            
            modifyInput = academyProfileRequest(image: nil, academyEmail: result.result.academyEmail, academyName: result.result.academyName, academyPhone: result.result.academyPhone, academyAddress: result.result.academyAddress, academyDetailAddress: result.result.academyDetailAddress, academyGernre: result.result.academyGernre, profileImgUrl: result.result.academyBackImgUrl ?? "")
            
            
        }else{
            
            presentAlert(title:  result.message)
            
        }
    
        
    }
    
    func profileModify(result : regularResponse){
        if result.isSuccess{
            presentAlert(title:  "저장 되었습니다.")
            
        }else{
            presentAlert(title:  result.message)
        }
        
        
    }
    
    
    func failedToRequest(){
        
        self.presentAlert(title: "서버와의 연결이 원활하지 않습니다")

    }

}
