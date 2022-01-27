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
