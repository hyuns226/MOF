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
     
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
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
         presentAlert(title: "문의하기", message: "\n회사 이메일 : mediveinkr@gmail.com\n\n개발자 이메일 : junhyuk2449@naver.com\n\n")
     }
     @IBAction func changePasswordAction(_ sender: Any) {
         
        
        let passVC = self.storyboard?.instantiateViewController(withIdentifier: "ChangePasswordViewController") as! ChangePasswordViewController
            
         self.navigationController?.pushViewController(passVC, animated: true)
        settingBackButton()
     }
     
     @IBAction func withdrawAction(_ sender: Any) {
       
         presentAlert(title: "회원 탈퇴", message: "회원 탈퇴 후 해당 아이디로는 재가입 하실 수 없습니다. 회원 탈퇴를 진행하시겠습니까?", isCancelActionIncluded: true, preferredStyle: .alert) { UIAlertAction in
             self.dataManager.academyWithdraw(academyIdx: KeyCenter.userIndex, delegate: self)
         }
    
     }
    
     @IBAction func logOutAction(_ sender: Any) {
         KeyCenter.userIndex = -1
         KeyCenter.LOGIN_TOKEN = ""
         KeyCenter.userType = ""
         
         let userDefaults = UserDefaults.standard
         userDefaults.removeObject(forKey: "ID")
         userDefaults.removeObject(forKey: "PW")
          
         print(userDefaults.value(forKey: "ID"))
         print(userDefaults.value(forKey: "PW"))
         
         UserDefaults.standard.synchronize()
         
         changeToLikeTab(tabBarController: self.tabBarController!)
         changeToLoginTab(tabBarController: self.tabBarController!)
         
         self.navigationController?.popViewController(animated: true)
     }
     
    func changeToLikeTab(tabBarController: UITabBarController){
        
                    let storyboard = UIStoryboard(name: "LikeStoryboard", bundle: nil)
                    let LikeVC = storyboard.instantiateViewController(withIdentifier: "LikeViewController") as! LikeViewController
                    let LikeNV = UINavigationController.init(rootViewController: LikeVC)
                    var allviews = tabBarController.viewControllers
        
        
                    allviews?.remove(at: 2)
                    allviews?.insert(LikeNV, at: 2)
       
        
                    tabBarController.setViewControllers(allviews, animated: true)
                    
                   
        tabBarController.tabBar.items?[2].selectedImage = #imageLiteral(resourceName: "coolicon_288").withRenderingMode(.alwaysOriginal)
        tabBarController.tabBar.items?[2].image = #imageLiteral(resourceName: "coolicon300").withRenderingMode(.alwaysOriginal)
        tabBarController.tabBar.items?[2].title = "Like"
        
        }
    
    func  changeToLoginTab(tabBarController: UITabBarController){
        let storyboard = UIStoryboard(name: "MyPageStoryboard", bundle: nil)
        let SignInVC = storyboard.instantiateViewController(withIdentifier: "SIgnInViewController") as! SIgnInViewController
        let SignInNV = UINavigationController.init(rootViewController: SignInVC)
        var allviews = tabBarController.viewControllers
        allviews?.remove(at: 3)
        allviews?.insert(SignInNV, at: 3)
        tabBarController.setViewControllers(allviews, animated: true)

        tabBarController.tabBar.items?[3].selectedImage = #imageLiteral(resourceName: "coolicon301").withRenderingMode(.alwaysOriginal).withTintColor(.mainPink)
        tabBarController.tabBar.items?[3].image = #imageLiteral(resourceName: "coolicon301").withRenderingMode(.alwaysOriginal).withTintColor(UIColor(hex: 0xB2B2B2))
        tabBarController.tabBar.items?[3].title = "MyPage"
        
        
    }
    
    
    
    
    
}

//API
extension AcademySettingViewController{
    func withdraw(result : regularResponse){
        if result.isSuccess{
            KeyCenter.userIndex = -1
            KeyCenter.LOGIN_TOKEN = ""
            KeyCenter.userType = ""
            
            let userDefaults = UserDefaults.standard
            userDefaults.removeObject(forKey: "ID")
            userDefaults.removeObject(forKey: "PW")
            userDefaults.removeObject(forKey: "savedID")
             
            print(userDefaults.value(forKey: "ID"))
            print(userDefaults.value(forKey: "PW"))
            
            UserDefaults.standard.synchronize()
            
            changeToLikeTab(tabBarController: self.tabBarController!)
            changeToLoginTab(tabBarController: self.tabBarController!)
            
            let alert = UIAlertController (title: nil, message: "회원 탈퇴가 완료 되었습니다.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel, handler:{ (alertOKAction) in
                self.dismiss(animated: false, completion: nil)
                self.navigationController?.popViewController(animated: true)
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
