//
//  SIgnUpViewController.swift
//  MOF
//
//  Created by 이현서 on 2021/12/30.
//

import UIKit
class SIgnInViewController : UIViewController{

    lazy var dataManager = UserMyPageDataManager()
    var loginInput = loginRequest(userEmail: "", userPWD: "")
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var autoLoginButton: UIButton!
    @IBOutlet weak var saveIDButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
      
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginButton.isEnabled = false
        loginButton.backgroundColor = #colorLiteral(red: 0.808078289, green: 0.8075512052, blue: 0.829269588, alpha: 1)
        
        NotificationCenter.default.addObserver(self, selector: #selector(checkTextField), name: UITextField.textDidChangeNotification, object: nil)
    }
    
//MARK - FUNCTION
    
    @IBAction func tempLogin(_ sender: Any) {
        tabBarController(tabBarController: self.tabBarController!)
        
    }
    
    
    //MARK: - 텍스트 필드 채워지면 버튼 활성화
    @objc func checkTextField(){
        let filteredArray = [emailTextField,passwordTextField].filter { $0?.text == "" }
        if (filteredArray.isEmpty){
           
            loginButton.isEnabled = true
            loginButton.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.70392102, alpha: 1)
            
        } else {
            loginButton.isEnabled = false
            loginButton.backgroundColor = #colorLiteral(red: 0.808078289, green: 0.8075512052, blue: 0.829269588, alpha: 1)
            
        }
    }
    
    
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
        
        loginInput.userEmail = emailTextField.text!
        loginInput.userPWD = passwordTextField.text!
        
        
        dataManager.login(loginInput, delegate: self)
        
       
        
    }
    
   
    
    
}

//MARK: - API
extension SIgnInViewController{
    
    
    func login(result : loginResponse){
        if result.isSuccess == true{
            print(result)
            
            KeyCenter.userIndex = result.result!.userIdx
            KeyCenter.LOGIN_TOKEN = result.result!.jwt
            
            tabBarController(tabBarController: self.tabBarController!)
            
        }else{
            self.presentAlert(title: result.message)
            
        }
    
    }
    
    func failedToRequest(){
        
        self.presentAlert(title: "서버와의 연결이 원활하지 않습니다")
    
    }
    
    
}

