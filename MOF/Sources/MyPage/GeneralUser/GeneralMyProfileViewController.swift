//
//  GeneralMyProfileViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/01/13.
//

import UIKit
import PhotosUI
class GeneralMyProfileViewController : UIViewController{
    
    let dataManager = UserMyPageDataManager()
    var modifyInput = userModifyRequest(userEmail: "", userName: "", userPhone: "", userAge: "", userGender: "", userAddress: "", userProfileImgUrl: nil)
    
    let picker = UIImagePickerController()
    var age = ""
    var gender = ""

    
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
       
        //내정보 조회
        dataManager.userProfile(userIdx: KeyCenter.userIndex, delegate: self)
        
        dismissKeyboardWhenTappedAround()
        print(KeyCenter.userIndex)
        profileImageView.layer.cornerRadius = 75
        picker.delegate = self
        ageTextField.delegate = self
        ageTextField.addTarget(self, action: #selector(chooseAge), for: .touchDown)
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
       
        navigationController?.setNavigationBarHidden(false, animated: animated)
       
    }
    
    //MARK:-FUNCTION
    
    
    func  settingInput(){
        

        modifyInput.userEmail = emailTextfField.text ?? ""
        modifyInput.userName = nameTextField.text ?? ""
        modifyInput.userPhone = phoneNumTextField.text ?? ""
        modifyInput.userAge = age
        modifyInput.userGender = gender
        
       
    }
    
    @IBAction func galleryButtonAction(_ sender: Any) {
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
       
        picker.allowsEditing = true
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
    
    
    
    @objc func chooseAge(_ textField: UITextField){
    let ageAS = UIAlertController(title: "연령대", message: nil, preferredStyle: .actionSheet)
    let teenAction = UIAlertAction(title: "10대", style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                self.ageTextField.text = "10대"
                self.age = "10"
    
    })
    let twentiesAction = UIAlertAction(title: "20대", style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                self.ageTextField.text = "20대"
                self.age = "20"
      
    })
    let thirtiesAction = UIAlertAction(title: "30대", style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                self.ageTextField.text = "30대"
                self.age = "30"
          
     
    })
    let fortiesAction = UIAlertAction(title: "40대", style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                self.ageTextField.text = "40대"
                self.age = "40"
      
    })
    let fiftiesAction = UIAlertAction(title: "50대", style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                self.ageTextField.text = "50대"
                self.age = "50"
     
    })
    let sixtiesAction = UIAlertAction(title: "60대", style: .default, handler: {
                (alert: UIAlertAction!) -> Void in
                self.ageTextField.text = "60대"
                self.age = "60"
        
    })
    
    let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: {
                (alert: UIAlertAction!) -> Void in
       
    })
        
    ageAS.addAction(teenAction)
    ageAS.addAction(twentiesAction)
    ageAS.addAction(thirtiesAction)
    ageAS.addAction(fortiesAction)
    ageAS.addAction(fiftiesAction)
    ageAS.addAction(sixtiesAction)
    ageAS.addAction(cancelAction)
    
 
    
    self.present(ageAS, animated: true, completion: nil)
    }
    
    @IBAction func maleButtonClicked(_ sender: Any) {
        maleButton.isSelected = true
        maleButton.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.7033678889, alpha: 1)
        femaleButton.backgroundColor = #colorLiteral(red: 0.9293304086, green: 0.929463923, blue: 0.9293012023, alpha: 1)
        femaleButton.isSelected = false
        gender = "Male"
        
       
    }
    
    @IBAction func femaleButtonClicked(_ sender: Any) {
        maleButton.isSelected = false
        femaleButton.isSelected = true
        femaleButton.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.7033678889, alpha: 1)
        maleButton.backgroundColor =  #colorLiteral(red: 0.9293304086, green: 0.929463923, blue: 0.9293012023, alpha: 1)
        gender = "Female"
    }
    
    
    @IBAction func saveButtonAction(_ sender: Any) {
        
       
        settingInput()
        print(modifyInput)
        
        dataManager.modify(modifyInput, image: profileImageView.image, userIndex: KeyCenter.userIndex, delegate: self)
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
    

   
}

//MARK: - API
extension GeneralMyProfileViewController{
    func modify(result : userModifyResponse){
        print(result)
        if result.isSuccess{
            presentAlert(title: "프로필 수정이 완료되었습니다")
        }else{
            presentAlert(title:  result.message)
        }
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
            phoneNumTextField.text = result.result?.userPhone
            ageTextField.text = result.result?.userAge
            age = result.result?.userAge ?? ""
          
            if result.result?.userGender == "Male"{
                maleButton.isSelected = true
                maleButton.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.7033678889, alpha: 1)
                femaleButton.backgroundColor = #colorLiteral(red: 0.9293304086, green: 0.929463923, blue: 0.9293012023, alpha: 1)
                femaleButton.isSelected = false
                gender = "Male"
            }else{
                maleButton.isSelected = false
                femaleButton.isSelected = true
                femaleButton.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.7033678889, alpha: 1)
                maleButton.backgroundColor =  #colorLiteral(red: 0.9293304086, green: 0.929463923, blue: 0.9293012023, alpha: 1)
                gender = "Female"
            }
            
            
            
        }else{
            presentAlert(title:  result.message)
            
            
        }
        
        
        
        
        
    }
    
    
    func failedToRequest(){
        
        presentAlert(title:  "서버와의 연결이 원활하지 않습니다")
    }
    
    
    
}


