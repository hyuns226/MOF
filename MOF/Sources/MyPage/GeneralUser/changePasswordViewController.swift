//
//  changePasswordViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/01/27.
//

import UIKit
class changePasswordViewController : UIViewController{
    
    let dataManager = UserMyPageDataManager()
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
        
        dataManager.password(passwordInput, userIndex: KeyCenter.userIndex, delegate: self)
        
        
    }
    
    
    
}


//MARK:- API
extension changePasswordViewController {
    func password(result : usersResponse){
        if result.isSuccess{
            presentAlert(title: "비밀번호 변경이 완료 되었습니다.")
        }else{
            presentAlert(title: "\(result.message)")
        }
        
    }
    
    func failedToRequest(message : String){
        
        presentAlert(title: message)
        
        
    }
    
    
    
    
    
    
}
