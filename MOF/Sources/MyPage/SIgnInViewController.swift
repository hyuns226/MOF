//
//  SIgnUpViewController.swift
//  MOF
//
//  Created by 이현서 on 2021/12/30.
//

import UIKit
class SIgnInViewController : UIViewController{

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var autoLoginButton: UIButton!
    @IBOutlet weak var saveIDButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
      
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//MARK - FUNCTION
    
    @IBAction func autoLoginAction(_ sender: Any) {
        autoLoginButton.isSelected =  !autoLoginButton.isSelected
      
        if autoLoginButton.isSelected == true{
            autoLoginButton.setImage(UIImage(named: "autoLogin_pink"), for: .normal)
            print(autoLoginButton.isSelected)
            print("클릭")
            
        }else{
            autoLoginButton.setImage(UIImage(named: "autoLogin_gray"), for: .normal)
            print(autoLoginButton.isSelected)
            print("안클릭")
            
        }
        
        
    }
    
    
    @IBAction func saveIDAction(_ sender: Any) {
        
        saveIDButton.isSelected = !saveIDButton.isSelected
        if saveIDButton.isSelected == true{
            saveIDButton.setImage(UIImage(named: "autoLogin_pink"), for: .normal)
            print("클릭")
        }else{
            saveIDButton.setImage(UIImage(named: "autoLogin_gray"), for: .normal)
            print("안클릭")
        }
        
        
        
    }
    

    
    
    //로그인 버튼 -> 마이페이지 이동
    func tabBarController(tabBarController: UITabBarController){
        
                    let storyboard = UIStoryboard(name: "MyPageStoryboard", bundle: nil)
                    let MyPageVC = storyboard.instantiateViewController(withIdentifier: "MyPageViewController") as! MyPageViewController
                    let MyPageNV = UINavigationController.init(rootViewController: MyPageVC)
                    var allviews = tabBarController.viewControllers
                    allviews?.remove(at: 3)
                    allviews?.insert(MyPageNV, at: 3)
                    tabBarController.setViewControllers(allviews, animated: true)
                  
               
            }


    @IBAction func loginButtonAction(_ sender: Any) {
        tabBarController(tabBarController: self.tabBarController!)
        
    }
    
   
    
    
}
