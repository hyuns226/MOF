//
//  SignUpViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/01/08.
//

import UIKit

protocol regionDelegate: class {
    func sendregionName(forShow : String)
}

class SignUpViewController : UIViewController{
    var restoreFrameValue = 0.0
    lazy var dataManager = UserMyPageDataManager()
    
    var usersInput : usersRequest = usersRequest(image: nil, userEmail: "", userPWD: "", userName: "", userPhone: "", userAge: "", userGender: "")
    
    
    var gender : String = ""
    var age = ""
    var passwordReady = false
    var yheight = 0.0
    var originHeight = 0.0
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    @IBOutlet weak var checkPassWordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumTextFiled: UITextField!
    @IBOutlet weak var AgeTextField: UITextField!
    @IBOutlet weak var genderTexField: UITextField!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var SignUpButton: UIButton!
    @IBOutlet weak var mainView: UIView!
  
 
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        dismissKeyboardWhenTapped()
        
        NotificationCenter.default.addObserver(self, selector: #selector(checkTextField), name: UITextField.textDidChangeNotification, object: nil)
        
        originHeight = self.view.frame.size.height
        yheight = self.view.frame.origin.y
        
        self.emailTextField.delegate = self
        self.passWordTextField.delegate = self
        self.checkPassWordTextField.delegate = self
        self.nameTextField.delegate = self
        self.phoneNumTextFiled.delegate = self
        self.AgeTextField.delegate = self
        self.genderTexField.delegate = self
    
      
        

        
        
        //textfield별 view y좌표 수정
        
        checkPassWordTextField.addTarget(self, action: #selector(changeY), for:  .editingDidBegin)
        nameTextField.addTarget(self, action: #selector(changeY), for: .editingDidBegin)
        phoneNumTextFiled.addTarget(self, action: #selector(changeY), for: .editingDidBegin)
        genderTexField.addTarget(self, action: #selector(changeY), for: .editingDidBegin)
        
        
        //emailtextfield 길이제한, 시작할때 테두리 없애기
        emailTextField.addTarget(self, action: #selector(emailEditingStarted), for: .editingDidBegin)
        emailTextField.addTarget(self, action: #selector(limitEmailLengh), for: .editingChanged)
        
        //passwordtextfield 비밀번호 확인
        passWordTextField.addTarget(self, action: #selector(checkPassWordTwo), for: .editingChanged)
        checkPassWordTextField.addTarget(self, action: #selector(checkPassWord), for: .editingChanged)
        
        genderTexField.addTarget(self, action: #selector(chooseGender), for: .touchDown)
        AgeTextField.addTarget(self, action: #selector(chooseAge), for: .touchDown)
        
        phoneNumTextFiled.addTarget(self, action: #selector(LimitePhone), for: .editingChanged)
        
        SignUpButton.isEnabled = false
        SignUpButton.layer.cornerRadius = 22
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("viewwi")
        print(self.yheight)
        self.view.frame.origin.y = self.yheight
        self.view.frame.size.height = originHeight
        print(self.yheight)
    }
    
    //MARK:-FUNCTION
    
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
 
    //텍스트 필드 채워지면 버튼 활성화
    @objc func checkTextField(){
        let filteredArray = [emailTextField,passWordTextField,checkPassWordTextField,nameTextField,phoneNumTextFiled,AgeTextField,genderTexField].filter { $0?.text == "" }
        if (filteredArray.isEmpty)&&passwordReady{
            SignUpButton.isEnabled = true
            SignUpButton.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.0862745098, blue: 0.6862745098, alpha: 1)
        } else{
            SignUpButton.isEnabled = false
            SignUpButton.backgroundColor = #colorLiteral(red: 0.808078289, green: 0.8075512052, blue: 0.829269588, alpha: 1)
        }
    }
    
    @objc func emailEditingStarted(){
        emailTextField.layer.borderWidth = 0
    }
    
    @objc func limitEmailLengh(){
        if (emailTextField.text?.count ?? 0 > 50) {
            emailTextField.deleteBackward()
        }
    }
    
    @objc func LimitePhone(){
        if (phoneNumTextFiled.text?.count ?? 0 > 12) {
            phoneNumTextFiled.deleteBackward()
        }
    }
    
    @objc func checkPassWord(){
        if passWordTextField.text != checkPassWordTextField.text{
            setTextfieldLayer(textfield : checkPassWordTextField)
            passwordErrorLabel.isHidden = false
            passwordReady = false
        }else{
                checkPassWordTextField.layer.borderWidth = 0
            passwordErrorLabel.isHidden = true
            passwordReady = true
            
        }
    }
    
    @objc func checkPassWordTwo(){
        if passWordTextField.text == checkPassWordTextField.text{
            checkPassWordTextField.layer.borderWidth = 0
        passwordErrorLabel.isHidden = true
            passwordReady = true
        }else{
            if checkPassWordTextField.text?.count != 0{
                setTextfieldLayer(textfield : checkPassWordTextField)
                passwordErrorLabel.isHidden = false
                passwordReady = false
            }
        }
    }
    
    func dismissKeyboardWhenTapped() {
        let tap: UITapGestureRecognizer =
            UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboards))
//       tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
        
    @objc func dismissKeyboards() {
        print("dismisskeyboard")
        self.view.endEditing(false)
        self.view.frame.origin.y = yheight
        self.view.frame.size.height = originHeight
        
    }
    @objc func changeY(){
      
        if nameTextField.isEditing{
            print(self.view.frame.origin.y)
            self.view.frame.origin.y = yheight
            self.view.frame.origin.y -= 80

        }else if phoneNumTextFiled.isEditing{
            self.view.frame.origin.y = yheight
            self.view.frame.origin.y -= 160
            
        }else if genderTexField.isEditing{
            
        }
    }

    
    func setTextfieldLayer(textfield : UITextField){
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor.mainPink.cgColor
    }
    
    @objc func chooseGender(_ textField: UITextField) {
        genderTexField.resignFirstResponder()
        self.view.frame.size.height = originHeight + 320
        self.view.frame.origin.y = yheight
        self.view.frame.origin.y -= 320
        
        let genderAS = UIAlertController(title: "성별", message: nil, preferredStyle: .actionSheet)
        let maleAction = UIAlertAction(title: "남성", style: .default, handler: {
                    (alert: UIAlertAction!) -> Void in
                    self.gender = "Male"
                    self.genderTexField.text = "남성"
                    self.checkTextField()
            self.view.frame.origin.y = self.yheight
            self.view.frame.size.height = self.originHeight
           
               
        })
        let femaleAction = UIAlertAction(title: "여성", style: .default, handler: {
                    (alert: UIAlertAction!) -> Void in
                    self.gender = "Female"
                    self.genderTexField.text = "여성"
                    self.checkTextField()
            self.view.frame.origin.y = self.yheight
            self.view.frame.size.height = self.originHeight
            
        })
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: {
                    (alert: UIAlertAction!) -> Void in
            self.view.frame.origin.y = self.yheight
            self.view.frame.size.height = self.originHeight
            
        })
            
        genderAS.addAction(maleAction)
        genderAS.addAction(femaleAction)
        genderAS.addAction(cancelAction)
               
        self.present(genderAS, animated: true, completion: nil)
        
    }
    
    @objc func chooseAge(_ textField: UITextField){
        print(AgeTextField.isEditing)
        self.phoneNumTextFiled.endEditing(true)
      
        self.view.frame.size.height = originHeight + 320
        self.view.frame.origin.y = yheight
        self.view.frame.origin.y -= 320
        
       
        print(AgeTextField.isEditing)
        
        let ageAS = UIAlertController(title: "연령대", message: nil, preferredStyle: .actionSheet)
        let teenAction = UIAlertAction(title: "10대", style: .default, handler: {
                    (alert: UIAlertAction!) -> Void in
                    self.AgeTextField.text = "10대"
                    self.age = "10"
            
                    self.checkTextField()
            self.view.frame.origin.y = self.yheight
            self.view.frame.size.height = self.originHeight
        })
        let twentiesAction = UIAlertAction(title: "20대", style: .default, handler: {
                    (alert: UIAlertAction!) -> Void in
                    self.AgeTextField.text = "20대"
                    self.age = "20"
                    self.checkTextField()
            self.view.frame.origin.y = self.yheight
            self.view.frame.size.height = self.originHeight
        })
        let thirtiesAction = UIAlertAction(title: "30대", style: .default, handler: {
                    (alert: UIAlertAction!) -> Void in
                    self.AgeTextField.text = "30대"
                    self.age = "30"
                    self.checkTextField()
            self.view.frame.origin.y = self.yheight
            self.view.frame.size.height = self.originHeight
        })
        let fortiesAction = UIAlertAction(title: "40대", style: .default, handler: {
                    (alert: UIAlertAction!) -> Void in
                    self.AgeTextField.text = "40대"
                    self.age = "40"
                    self.checkTextField()
            self.view.frame.origin.y = self.yheight
            self.view.frame.size.height = self.originHeight
        })
        let fiftiesAction = UIAlertAction(title: "50대", style: .default, handler: {
                    (alert: UIAlertAction!) -> Void in
                    self.AgeTextField.text = "50대"
                    self.age = "50"
                    self.checkTextField()
            self.view.frame.origin.y = self.yheight
            self.view.frame.size.height = self.originHeight
        })
        let sixtiesAction = UIAlertAction(title: "60대", style: .default, handler: {
                    (alert: UIAlertAction!) -> Void in
                    self.AgeTextField.text = "60대"
                    self.age = "60"
            self.checkTextField()
            self.view.frame.origin.y = self.yheight
            self.view.frame.size.height = self.originHeight
            
        })
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel, handler: {
                    (alert: UIAlertAction!) -> Void in
            self.view.frame.origin.y = self.yheight
            self.view.frame.size.height = self.originHeight
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

    
    func setUserInput(){
        usersInput.image = nil
        usersInput.userEmail = emailTextField.text ?? ""
        usersInput.userPWD = passWordTextField.text ?? ""
        usersInput.userName = nameTextField.text ?? ""
        usersInput.userPhone = phoneNumTextFiled.text ?? ""
        usersInput.userAge = age
        usersInput.userGender = gender
        
    }
    
    @IBAction func SignUpButtonAction(_ sender: Any) {
        setUserInput()
        print(usersInput)
        
       dataManager.users(usersInput, delegate: self)
//        let welcomeVC = self.storyboard?.instantiateViewController(identifier: "WelcomViewController") as! WelcomViewController
//
//        welcomeVC.welcomeText = usersInput.userName + "님, 안녕하세요!"
//        self.navigationController?.pushViewController(welcomeVC, animated: true)
//       welcomeVC.presentAlert(title: "회원가입이 완료되었습니다.")
       
       
    }
}


//MARK: - API
extension SignUpViewController{
    func users(result : usersResponse){
        if result.isSuccess == true{
            print(result)
            let welcomeVC = self.storyboard?.instantiateViewController(identifier: "WelcomViewController") as! WelcomViewController
            welcomeVC.welcomeText = usersInput.userName + "님, 안녕하세요!"
            welcomeVC.userIndex = result.result!.userIdx
            print("userindex : \(result.result!.userIdx)")
            welcomeVC.modalPresentationStyle = .fullScreen
            self.navigationController?.pushViewController(welcomeVC, animated: true)
            welcomeVC.presentAlert(title: "회원가입이 완료되었습니다.")
            
        }else{
            switch(result.code){
            case 2001,2002,2003,3001 :
                presentAlert(title: result.message)
                setTextfieldLayer(textfield: emailTextField)
                break
            case 2006:
                presentAlert(title: result.message)
                setTextfieldLayer(textfield: nameTextField)
                break
            case 2011:
                presentAlert(title: result.message)
                setTextfieldLayer(textfield: passWordTextField)
                break
            case 2022:
                presentAlert(title: result.message)
                setTextfieldLayer(textfield: phoneNumTextFiled)
                break
            case 2023:
                presentAlert(title: result.message)
                setTextfieldLayer(textfield: AgeTextField)
                break
            case 2024:
                presentAlert(title: result.message)
                setTextfieldLayer(textfield: genderTexField)
                break
            default :
                presentAlert(title: result.message)
            }
            
            self.presentAlert(title: result.message)
            
        }
    
    }
    
    func failedToRequest(message : String){
        
        self.presentAlert(title: message)
    
    }
    
    
}

extension SignUpViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch(textField){
        case emailTextField :
            passWordTextField.becomeFirstResponder()
            
            
            break
        case passWordTextField :
            
            checkPassWordTextField.becomeFirstResponder()
           
            print( self.view.frame.origin.y)
            break
        case checkPassWordTextField :
            nameTextField.becomeFirstResponder()
            print( self.view.frame.origin.y)
          
            
            break
        case nameTextField :
            phoneNumTextFiled.becomeFirstResponder()
         
            
            break
        case phoneNumTextFiled :
            emailTextField.resignFirstResponder()
            passWordTextField.resignFirstResponder()
            checkPassWordTextField.resignFirstResponder()
            nameTextField.resignFirstResponder()
            phoneNumTextFiled.resignFirstResponder()
            AgeTextField.resignFirstResponder()
            genderTexField.resignFirstResponder()
            passwordErrorLabel.resignFirstResponder()
            SignUpButton.resignFirstResponder()
            
            AgeTextField.becomeFirstResponder()
            break
        case AgeTextField :
            emailTextField.resignFirstResponder()
            passWordTextField.resignFirstResponder()
            checkPassWordTextField.resignFirstResponder()
            nameTextField.resignFirstResponder()
            phoneNumTextFiled.resignFirstResponder()
            AgeTextField.resignFirstResponder()
            genderTexField.resignFirstResponder()
            passwordErrorLabel.resignFirstResponder()
            SignUpButton.resignFirstResponder()
            
            genderTexField.becomeFirstResponder()
          
            break
        case genderTexField :
            break
        default:
            print("")
        }
            
            return true
        }
}



