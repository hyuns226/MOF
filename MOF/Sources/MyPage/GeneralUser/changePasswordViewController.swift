//
//  changePasswordViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/01/27.
//

import UIKit
class ChangePasswordViewController : UIViewController{
    
    let dataManager = UserMyPageDataManager()
    let dataManager2 = AcademyMyPageDataManager()
    var passwordInput = passwordRequest(pastPWD: "", newPWD: "")
    
    @IBOutlet weak var nowPasswordTextField: UITextField!
    @IBOutlet weak var newPasswordTextField: UITextField!
    @IBOutlet weak var changePasswordButton: UIButton!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changePasswordButton.isEnabled = false
        changePasswordButton.backgroundColor = #colorLiteral(red: 0.808078289, green: 0.8075512052, blue: 0.829269588, alpha: 1)
        
        NotificationCenter.default.addObserver(self, selector: #selector(checkTextField), name: UITextField.textDidChangeNotification, object: nil)
    }
    
    
    //MARK: - 텍스트 필드 채워지면 버튼 활성화
    @objc func checkTextField(){
        let filteredArray = [nowPasswordTextField,newPasswordTextField].filter { $0?.text == "" }
        if (filteredArray.isEmpty){
            changePasswordButton.isEnabled = true
            changePasswordButton.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.0862745098, blue: 0.6862745098, alpha: 1)
            
        } else {
          
            changePasswordButton.isEnabled = false
            changePasswordButton.backgroundColor = #colorLiteral(red: 0.808078289, green: 0.8075512052, blue: 0.829269588, alpha: 1)
            
        }
    }
    
    
    //MARK :- FUNCTION
    @IBAction func changePasswordButtonAction(_ sender: Any) {
        
        passwordInput.pastPWD =   nowPasswordTextField.text!
        
        passwordInput.newPWD = newPasswordTextField.text!
        
        print("userID :\(KeyCenter.userIndex)")
        
        if KeyCenter.userType == "general"{
            dataManager.password(passwordInput, userIndex: KeyCenter.userIndex, delegate: self)
        }else{
            dataManager2.password(passwordInput, academyIdx: KeyCenter.userIndex, delegate: self)
        }
        
        
        
    }
    
}


//MARK:- API
extension ChangePasswordViewController {
    func password(result : userPasswordResponse){
        print(result)
        if result.isSuccess{
            let userDefaults = UserDefaults.standard
            print(userDefaults.value(forKey: "PW"))
            if userDefaults.value(forKey: "PW") != nil{
                userDefaults.setValue(passwordInput.newPWD, forKey: "PW")
            }
            
            let alert = UIAlertController (title: nil, message: "비밀번호 변경이 완료 되었습니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler:{ (alertOKAction) in
                self.dismiss(animated: false, completion: nil)
                self.navigationController!.popViewController(animated: true)
            }))
            
            self.present(alert, animated: true, completion: nil)
            
           
        }else{
            presentAlert(title: "\(result.message)")
        }
        
    }
    
    func academyPassword(result : passwordResponse){
        if result.isSuccess{
            
            let userDefaults = UserDefaults.standard
            print(userDefaults.value(forKey: "PW"))
            if userDefaults.value(forKey: "PW") != nil{
                userDefaults.setValue(passwordInput.newPWD, forKey: "PW")
            }
            
            let alert = UIAlertController (title: nil, message: "비밀번호 변경이 완료 되었습니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler:{ (alertOKAction) in
                self.dismiss(animated: false, completion: nil)
                self.navigationController!.popViewController(animated: true)
            }))
            
            self.present(alert, animated: true, completion: nil)
        }else{
            presentAlert(title: "\(result.message)")
        }
    }
    func failedToRequest(){
        
        self.presentAlert(title: "서버와의 연결이 원활하지 않습니다")
        
        
    }
    
    
    
    
    
    
}
