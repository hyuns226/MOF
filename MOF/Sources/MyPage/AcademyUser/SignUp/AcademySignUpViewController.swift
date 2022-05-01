//
//  AcademySignUpViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/01/18.
//

import UIKit

class AcademySignUpViewController : UIViewController{
    
    var emailReady = false
    var passwordReady = false
    var signUpInput = AcademySignUpRequest(image: "", academyEmail: "", academyPWD: "", academyName: "", academyPhone: "", academyDetailAddress: "", academyAddress: "", academyBuilding:"", academyGernre: "")
    
    
    var yheight = 0.0
    var originHeight = 0.0
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var checkPassWordTextField: UITextField!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var emailErrorLabel: UILabel!
    @IBOutlet weak var academyNameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var detailAddressTextField: UITextField!
    @IBOutlet weak var phoneNumTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var nextButtonItem: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissKeyboardWhenTapped()

        NotificationCenter.default.addObserver(self, selector: #selector(checkAllWritten), name: UITextField.textDidChangeNotification, object: nil)
        
        originHeight = self.view.frame.size.height
        yheight = self.view.frame.origin.y
        
        self.emailTextField.delegate = self
        self.passwordTextField.delegate = self
        self.checkPassWordTextField.delegate = self
        self.academyNameTextField.delegate = self
        self.addressTextField.delegate = self
        self.detailAddressTextField.delegate = self
        self.phoneNumTextField.delegate = self
        
        self.emailTextField.becomeFirstResponder()
        
        //textfield별 view y좌표 수정
        
        academyNameTextField.addTarget(self, action: #selector(changeY), for: .editingDidBegin)
        addressTextField.addTarget(self, action: #selector(changeY), for: .editingDidBegin)
        detailAddressTextField.addTarget(self, action: #selector(changeY), for: .editingDidBegin)
        phoneNumTextField.addTarget(self, action: #selector(changeY), for: .editingDidBegin)
        
        //addresstextfield -> 카카오 주소 api 화면
        addressTextField.addTarget(self, action: #selector(textFieldTouched), for: .editingDidBegin)

        //emailtextfield 길이제한, 시작할때 테두리 없애기
        emailTextField.addTarget(self, action: #selector(emailEditingStarted), for: .editingDidBegin)
        emailTextField.addTarget(self, action: #selector(limitEmailLengh), for: .editingChanged)
       
        //passwordtextfield 비밀번호 확인
        passwordTextField.addTarget(self, action: #selector(checkPassWordTwo), for: .editingChanged)
        checkPassWordTextField.addTarget(self, action: #selector(checkPassWord), for: .editingChanged)
        
        //전화번호 길이 제한
        phoneNumTextField.addTarget(self, action: #selector(LimitePhone), for: .editingChanged)
        nextButton.isEnabled = false
        nextButton.layer.cornerRadius = 22
        nextButtonItem.isEnabled = false
        nextButtonItem.tintColor = .gray
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        print("viewwi")
        print(self.yheight)
        self.view.frame.origin.y = yheight
        self.view.frame.size.height = originHeight
        print(self.yheight)
    }
    
    //MARK:- FUCTION
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
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
       if academyNameTextField.isEditing{
            
         }else if detailAddressTextField.isEditing{
            self.view.frame.size.height = originHeight
            self.view.frame.size.height += 160
            
            self.view.frame.origin.y = yheight
            self.view.frame.origin.y -= 160
        
            
            
        }else if phoneNumTextField.isEditing{
            self.view.frame.size.height = originHeight
            self.view.frame.size.height += 240

            
            self.view.frame.origin.y = yheight
            self.view.frame.origin.y -= 240
        
            
        }
    }
    
    @objc func textFieldTouched(_ textField: UITextField) {
        self.view.endEditing(false)
      // addressTextField.becomeFirstResponder()
//        addressTextField.resignFirstResponder()
        self.view.frame.size.height = originHeight
        self.view.frame.origin.y = yheight
        
        let kakaoPostCodeVC = self.storyboard?.instantiateViewController(withIdentifier: "kakaoPostCodeViewController") as!  kakaoPostCodeViewController
     //   addressTextField.resignFirstResponder()
        kakaoPostCodeVC.delegate = self
        self.present(kakaoPostCodeVC, animated: true)
    }
    
    @objc func checkAllWritten(){
        let filteredArray = [emailTextField,
                             passwordTextField,
                             checkPassWordTextField,
                             academyNameTextField,
                             addressTextField,
                             detailAddressTextField,
                             phoneNumTextField].filter { $0?.text == "" }
        if (filteredArray.isEmpty)&&passwordReady&&emailReady{
            nextButton.isEnabled = true
            nextButton.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.0862745098, blue: 0.6862745098, alpha: 1)
            
            nextButtonItem.isEnabled = true
            nextButtonItem.tintColor = #colorLiteral(red: 0.9450980392, green: 0.0862745098, blue: 0.6862745098, alpha: 1)
            
        } else{
            nextButton.isEnabled = false
            nextButton.backgroundColor = #colorLiteral(red: 0.808078289, green: 0.8075512052, blue: 0.829269588, alpha: 1)
            
            nextButtonItem.isEnabled = false
            nextButtonItem.tintColor = .gray
        }
    }
    
    @objc func emailEditingStarted(){
        emailTextField.layer.borderWidth = 0
    }
    
    @objc func limitEmailLengh(){
        if (emailTextField.text?.count ?? 0 > 50) {
            emailTextField.deleteBackward()
        }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if emailTest.evaluate(with: emailTextField.text) == false{
            setTextfieldLayer(textfield : emailTextField)
            emailErrorLabel.isHidden = false
            emailReady = false
        }else{
            emailTextField.layer.borderWidth = 0
            emailErrorLabel.isHidden = true
            emailReady = true
        }
    }
    
    @objc func checkPassWord(){
        if passwordTextField.text != checkPassWordTextField.text{
            setTextfieldLayer(textfield : checkPassWordTextField)
            passwordErrorLabel.isHidden = false
            passwordReady = false
        }else{
                checkPassWordTextField.layer.borderWidth = 0
            passwordErrorLabel.isHidden = true
            passwordReady = true
            
        }
    }
    
    func setTextfieldLayer(textfield : UITextField){
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor.mainPink.cgColor
    }
    
    @objc func checkPassWordTwo(){
        if passwordTextField.text == checkPassWordTextField.text{
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
    
    @objc func LimitePhone(){
        if (phoneNumTextField.text?.count ?? 0 > 12) {
            phoneNumTextField.deleteBackward()
        }
    }
    
    func setInputData(){
       
        self.signUpInput.academyEmail = emailTextField.text ?? ""
        self.signUpInput.academyPWD = passwordTextField.text ?? ""
        self.signUpInput.academyName = academyNameTextField.text ?? ""
        self.signUpInput.academyPhone = phoneNumTextField.text ?? ""
        self.signUpInput.academyBuilding = detailAddressTextField.text ?? ""
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        
        let genreVC = self.storyboard?.instantiateViewController(identifier: "AcademySignUpSelectGenreViewController") as! AcademySignUpSelectGenreViewController
        
        //회원 가입 데이터 전달
        setInputData()
        genreVC.signUpInput = self.signUpInput
        
        print(signUpInput)
        self.navigationController?.pushViewController(genreVC, animated: true)
        
    }
    @IBAction func nextButtonItemAction(_ sender: Any) {
        let genreVC = self.storyboard?.instantiateViewController(identifier: "AcademySignUpSelectGenreViewController") as! AcademySignUpSelectGenreViewController
        
        //회원 가입 데이터 전달
        setInputData()
        genreVC.signUpInput = self.signUpInput
        
        print(signUpInput)
        self.navigationController?.pushViewController(genreVC, animated: true)
    }
}

extension AcademySignUpViewController : UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch(textField){
        case emailTextField :
            passwordTextField.becomeFirstResponder()
            break
        case passwordTextField :
            checkPassWordTextField.becomeFirstResponder()
            break
        case checkPassWordTextField :
            academyNameTextField.becomeFirstResponder()
            break
        case academyNameTextField :
            academyNameTextField.resignFirstResponder()
            addressTextField.becomeFirstResponder()
            
            self.view.frame.size.height = originHeight
            self.view.frame.origin.y = yheight
            break
        case addressTextField :
            detailAddressTextField.becomeFirstResponder()
            break
        case detailAddressTextField :
            phoneNumTextField.becomeFirstResponder()
          
            break
        default:
            print("")
        }
            
            return true
        }
    
}

//MARK:- PROTOCOL
extension AcademySignUpViewController : kakaoPostCodeProtocol{
    func sendPostCode(forShow: String, forSend: String, addressForSearch : String) {
        addressTextField.text = forShow
        signUpInput.academyDetailAddress = forSend
        signUpInput.academyAddress = addressForSearch
    }

}

