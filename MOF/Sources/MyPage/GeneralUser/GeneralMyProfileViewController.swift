//
//  GeneralMyProfileViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/01/13.
//

import UIKit
class GeneralMyProfileViewController : UIViewController{
    
    let dataManager = UserMyPageDataManager()
    var modifyInput = userModifyRequest(userEmail: nil, userName: nil, userPhone: nil, userAge: nil, userGender: nil, userAddress: nil, userProfileImgUrl: nil)
    
    @IBOutlet weak var imageViewController: UIImageView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var emailTextfField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!
    @IBOutlet weak var addressTextField: UIButton!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        print(KeyCenter.userIndex)
        //내정보 조회
        dataManager.userProfile(userIdx: KeyCenter.userIndex, delegate: self)
        
    }
    
    func  settingInput(){
        
//        modifyInput.userAddress =
//        modifyInput.userEmail =
//        modifyInput.userName =
//            modifyInput.userPhone
//        modifyInput.userAge =
//        modifyInput.userGender =
//        modifyInput.userAddress =
        
        
    }
    
    
    @IBAction func saveButtonAction(_ sender: Any) {
        
        settingInput()
        
        
        
        dataManager.modify(modifyInput, userIndex: KeyCenter.userIndex, delegate: self)
    }
}

//MARK: - API
extension GeneralMyProfileViewController{
    func modify(result : userModifyResponse){
        
        presentAlert(title: result.message)
        
    }
    
    func userProfile(result : userProfileResponse){
        
        
        print(result)
        
        if result.isSuccess{
            print(result)
            //imageViewController.image = UIImage()
            emailTextfField.text = result.result?.userEmail
            nameTextField.text = result.result?.userName
            phoneNumTextField.text = result.result?.userPhone
            ageTextField.text = result.result?.userAge
            addressTextField.setTitle(result.result?.userAddress, for: .normal)
            if result.result?.userGender == "Male"{
                maleButton.isSelected = true
                maleButton.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.7033678889, alpha: 1)
                maleButton.backgroundColor = #colorLiteral(red: 0.8077631593, green: 0.8079000115, blue: 0.8292447925, alpha: 1)
                femaleButton.isSelected = false
            }else{
                maleButton.isSelected = false
                femaleButton.isSelected = true
                femaleButton.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.7033678889, alpha: 1)
                maleButton.backgroundColor = #colorLiteral(red: 0.8077631593, green: 0.8079000115, blue: 0.8292447925, alpha: 1)
            }
            
            
            
        }else{
            presentAlert(title:  result.message)
            
            
        }
        
        
        
        
        
    }
    
    
    func failedToRequest(){
        
        presentAlert(title:  "서버와의 연결이 원활하지 않습니다")
    }
    
    
    
}


