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
    
    let picker = UIImagePickerController()
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var emailTextfField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var maleButton: UIButton!
    @IBOutlet weak var femaleButton: UIButton!

    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
       
        
        print(KeyCenter.userIndex)
        profileImageView.layer.cornerRadius = 75
        picker.delegate = self
        ageTextField.delegate = self
        
        
        //내정보 조회
        dataManager.userProfile(userIdx: KeyCenter.userIndex, delegate: self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    //MARK:-FUNCTION
    func  settingInput(){
        
       
      
//        modifyInput.userEmail = emailTextfField.text
//        modifyInput.userName = nameTextField.text
//        modifyInput.userPhone = phoneNumTextField.text
//        modifyInput.userAge = ageTextField.text
       // modifyInput.userGender =
       
        
        
    }
    
    @IBAction func galleryButtonAction(_ sender: Any) {
        openlibrary()
    }
    
    func openlibrary(){
        picker.sourceType = .photoLibrary
        picker.modalPresentationStyle = .fullScreen
        present(picker, animated: true)
        
    }
    
    
    @IBAction func nameEditingChanged(_ sender: Any) {
        checkMaxLength(textField: nameTextField, maxLength: 50)
        //이메일 형식 확인
    }
    @IBAction func phoneEditingChanged(_ sender: Any) {
        checkMaxLength(textField: phoneNumTextField, maxLength: 11)
        //휴대폰 형식 확인
    }
    @IBAction func ageEditingChanged(_ sender: Any) {
        checkMaxLength(textField: ageTextField, maxLength: 2)
        
    }
    
    @IBAction func ageEditingDidEnd(_ sender: Any) {
        checkAge()
    }
    @IBAction func saveButtonAction(_ sender: Any) {
        
        print(ageTextField.text)
        checkAge()
        print(ageTextField.text)
        settingInput()
        
        
        
//        dataManager.modify(modifyInput, userIndex: KeyCenter.userIndex, delegate: self)
    }
}

//MARK:- EXTENSION

//MARK:- IMAGE PICKER
extension GeneralMyProfileViewController : UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    func imagePickerController(_ picker : UIImagePickerController, didFinishPickingMediaWithInfo info : [UIImagePickerController.InfoKey : Any]){
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
        
            profileImageView.image = image
            
            self.dismiss(animated: true, completion: nil)
            
        }
    
    }
}

//MARK:- UITextFieldDelegate
extension GeneralMyProfileViewController : UITextFieldDelegate{
    
    func checkMaxLength(textField: UITextField!, maxLength: Int) {
        if (textField.text?.count ?? 0 > maxLength) {
            textField.deleteBackward()
        }
        
        if textField == ageTextField{
           
        }
    }
    
    func checkAge(){
        if (Int(ageTextField.text ?? "0") ?? 0 < 10){
            ageTextField.text = "10"
        }else{
            ageTextField.text = String(ageTextField.text ?? "").prefix(1) + "0"
        }
        
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
            
            if let url = URL(string: result.result?.userProfileImgUrl ?? "") {
                profileImageView.kf.setImage(with: url)
            } else {
                profileImageView.image = UIImage(named: "defaultImage")
            }
        
          
            emailTextfField.text = result.result?.userEmail
            nameTextField.text = result.result?.userName
            phoneNumTextField.text = result.result?.userPhone.hyphen()
            ageTextField.text = result.result?.userAge
          
            if result.result?.userGender == "Male"{
                maleButton.isSelected = true
                maleButton.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.7033678889, alpha: 1)
                femaleButton.backgroundColor = #colorLiteral(red: 0.9293304086, green: 0.929463923, blue: 0.9293012023, alpha: 1)
                femaleButton.isSelected = false
            }else{
                maleButton.isSelected = false
                femaleButton.isSelected = true
                femaleButton.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.7033678889, alpha: 1)
                maleButton.backgroundColor =  #colorLiteral(red: 0.9293304086, green: 0.929463923, blue: 0.9293012023, alpha: 1)
            }
            
            
            
        }else{
            presentAlert(title:  result.message)
            
            
        }
        
        
        
        
        
    }
    
    
    func failedToRequest(){
        
        presentAlert(title:  "서버와의 연결이 원활하지 않습니다")
    }
    
    
    
}


