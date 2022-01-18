//
//  GeneralSettingViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/01/13.
//

import UIKit
class GeneralSettingViewController : UIViewController{
    
   lazy var dataManager = UserMyPageDataManager()
    
    @IBOutlet weak var alertButton: UIButton!
    @IBOutlet weak var TermsOfUseButton: UIButton!
    @IBOutlet weak var privacyPolicyButton: UIButton!
    @IBOutlet weak var openSrcLicenseButton: UIButton!
    @IBOutlet weak var InqueryButton: UIButton!
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
    
    @IBAction func withdrawAction(_ sender: Any) {
        
        print("clicked")
        dataManager.status(userIndex: KeyCenter.userIndex, delegate: self)
    }
    @IBAction func logOutAction(_ sender: Any) {
        print("clicked")
    }
    
    
    
}

//MARK:- API
extension GeneralSettingViewController{
    
    func status(result : statusResponse){
        if result.isSuccess{
            presentAlert(title: "회원 탈퇴가 완료 되었습니다.")
        }else{
            presentAlert(title: "\(result.message)")
        }
        
    }
    
    func failedToRequest(message : String){
        
        presentAlert(title: message)
        
        
    }
    
    
}

