//
//  AcademySignUpViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/01/18.
//

import UIKit
class AcademySignUpViewController : UIViewController{
    
    var isTextFieldReady = false
    var isButtonReady = false
    var signUpInput = AcademySignUpRequest(image: "", academyEmail: "", academyPWD: "", academyName: "", academyPhone: "", academyDetailAddress: "", academyAddress: "", academyGernre: "")
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var checkPassWordTextField: UITextField!
    @IBOutlet weak var academyNameTextField: UITextField!
    @IBOutlet weak var selectAddressButton: UIButton!
    @IBOutlet weak var detailAddressTextField: UITextField!
    @IBOutlet weak var phoneNumTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        NotificationCenter.default.addObserver(self, selector: #selector(checkAllWritten), name: UITextField.textDidChangeNotification, object: nil)
    }
    
    //MARK:- FUCTION
    @IBAction func nextButtonAction(_ sender: Any) {
        
        let genreVC = self.storyboard?.instantiateViewController(identifier: "AcademySignUpSelectGenreViewController") as! AcademySignUpSelectGenreViewController
        
        //회원 가입 데이터 전달
        setInputData()
        genreVC.signUpInput = self.signUpInput
        
        self.navigationController?.pushViewController(genreVC, animated: true)
        
        
    }
    
    func setInputData(){
       
        self.signUpInput.academyEmail = emailTextField.text ?? ""
        self.signUpInput.academyPWD = passwordTextField.text ?? ""
        self.signUpInput.academyName = academyNameTextField.text ?? ""
        self.signUpInput.academyPhone = phoneNumTextField.text ?? ""
        self.signUpInput.academyAddress = "서울시 광진구" //임시
        self.signUpInput.academyDetailAddress = detailAddressTextField.text ?? ""
          
        
    }
    
    
    
    @objc func checkAllWritten(){
        let filteredArray = [emailTextField,passwordTextField,checkPassWordTextField,academyNameTextField,detailAddressTextField,phoneNumTextField].filter { $0?.text == "" }
        if (filteredArray.isEmpty){
            isTextFieldReady = true
            if isButtonReady == true{
                nextButton.isEnabled = true
                nextButton.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.0862745098, blue: 0.6862745098, alpha: 1)
                
            }else{
                nextButton.isEnabled = false
                nextButton.backgroundColor = #colorLiteral(red: 0.808078289, green: 0.8075512052, blue: 0.829269588, alpha: 1)
            
            }
            
            
        } else {
            isTextFieldReady = false
            nextButton.isEnabled = false
            nextButton.backgroundColor = #colorLiteral(red: 0.808078289, green: 0.8075512052, blue: 0.829269588, alpha: 1)
            
        }
    }
    
    
    func checkButton(){
        if (isButtonReady && isTextFieldReady){
            nextButton.isEnabled = true
            nextButton.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.0862745098, blue: 0.6862745098, alpha: 1)
        }
        
        print(isButtonReady)
        print(isTextFieldReady)
        
        
        
        
    }
    
    
    
}




