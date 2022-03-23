//
//  AcademySettingViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/02/10.
//

import Foundation
import UIKit
import SnapKit

class AcademySettingViewController : UIViewController{
    
    lazy var dataManager = AcademyMyPageDataManager()
     
     @IBOutlet weak var alertButton: UIButton!
     @IBOutlet weak var TermsOfUseButton: UIButton!
     @IBOutlet weak var privacyPolicyButton: UIButton!
     @IBOutlet weak var openSrcLicenseButton: UIButton!
     @IBOutlet weak var InqueryButton: UIButton!
    @IBOutlet weak var changePasswordButton: UIButton!
    @IBOutlet weak var WithdrawButton: UIButton!
     @IBOutlet weak var logOutButton: UIButton!
     
     override func viewDidLoad() {
         super.viewDidLoad()
     }
     
     
     //MARK:- FUNCTION
     
     @IBAction func AlertAction(_ sender: Any) {
         print("clicked")
     }
     @IBAction func TermsOfUseAction(_ sender: Any) {
         print("clicked")
     }
     @IBAction func privacyPolicyAction(_ sender: Any) {
         print("clicked")
     }
     @IBAction func OpenSrcLicenseAction(_ sender: Any) {
         print("clicked")
     }
     @IBAction func InqueryAction(_ sender: Any) {
         print("clicked")
     }
     @IBAction func changePasswordAction(_ sender: Any) {
         
        
        let passVC = self.storyboard?.instantiateViewController(withIdentifier: "ChangePasswordViewController") as! ChangePasswordViewController
            
        self.present(passVC, animated: false)
        print("clicked")
         
     }
     
     @IBAction func withdrawAction(_ sender: Any) {
       
        presentAlert(title: "회원탈퇴", message: "탈퇴하시겠습니까?", isCancelActionIncluded: true, preferredStyle: .alert) { (UIAlertAction) in
            self.dataManager.academyWithdraw(academyIdx: KeyCenter.userIndex, delegate: self)
        }
    
     }
    
     @IBAction func logOutAction(_ sender: Any) {
         print("clicked")
     }
     
    
    
    
    
    
}

//API
extension AcademySettingViewController{
    func withdraw(result : regularResponse){
        if result.isSuccess{
            
            self.presentAlert(title: "회원 탈퇴가 완료되었습니다.")
        }
        
        
        
    }
    
    
    func failedToRequest(){
        
        self.presentAlert(title: "서버와의 연결이 원활하지 않습니다")

    }
    
    
}
