//
//  SIgnUpViewController.swift
//  MOF
//
//  Created by 이현서 on 2021/12/30.
//

import UIKit
class SIgnInViewController : UIViewController{

    var restoreFrameValue : CGFloat = 0.0
    
    lazy var dataManager = UserMyPageDataManager()
    var loginInput = loginRequest(userEmail: "", userPWD: "")
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var autoLoginButton: UIButton!
    @IBOutlet weak var saveIDButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
      
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        restoreFrameValue = self.view.frame.origin.y
        dismissKeyboardWhenTappedAround()
       
        
        navigationController?.navigationBar.shadowImage = UIImage()
        
        settingSavedID()
        
        loginButton.isEnabled = false
        loginButton.backgroundColor = #colorLiteral(red: 0.808078289, green: 0.8075512052, blue: 0.829269588, alpha: 1)
        
        NotificationCenter.default.addObserver(self, selector: #selector(checkTextField), name: UITextField.textDidChangeNotification, object: nil)
    }
    
//MARK - FUNCTION
    
    
    
    func settingSavedID(){
        let userDefaults = UserDefaults.standard
        if userDefaults.value(forKey: "savedID") != nil{
            emailTextField.text = userDefaults.value(forKey: "savedID") as! String
            saveIDButton.isSelected = true
            saveIDButton.setImage(UIImage(named: "autoLogin_pink"), for: .normal)
            
        }
    
    }
    
    @IBAction func tempLogin(_ sender: Any) {
        changeToGeneralUser(tabBarController: self.tabBarController!)
        
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
            autoLoginButton.setImage(UIImage(named: "autoLogin_pink"), for: .selected)
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
            saveIDButton.setImage(UIImage(named: "autoLogin_pink"), for: .selected)
            print("클릭")
        }else{
          
            saveIDButton.setImage(UIImage(named: "autoLogin_gray"), for: .normal)
            print("안클릭")
        }
        
        
        
    }
    

    
    
    //로그인 버튼 -> 마이페이지 이동
    func changeToGeneralUser(tabBarController: UITabBarController){
        
                    let storyboard = UIStoryboard(name: "MyPageStoryboard", bundle: nil)
                    let MyPageVC = storyboard.instantiateViewController(withIdentifier: "MyPageViewController") as! MyPageViewController
                    let MyPageNV = UINavigationController.init(rootViewController: MyPageVC)
                    var allviews = tabBarController.viewControllers
                    allviews?.remove(at: 3)
                    allviews?.insert(MyPageNV, at: 3)
                    tabBarController.setViewControllers(allviews, animated: true)
        
                    tabBarController.tabBar.items?[3].selectedImage = #imageLiteral(resourceName: "coolicon301").withRenderingMode(.alwaysOriginal).withTintColor(.mainPink)
                    tabBarController.tabBar.items?[3].image = #imageLiteral(resourceName: "coolicon301").withRenderingMode(.alwaysOriginal).withTintColor(UIColor(hex: 0xB2B2B2))
                    tabBarController.tabBar.items?[3].title = "MyPage"
                    
               
            }
    
    //로그인 버튼 -> 학원 마이페이지 이동
    func changeToAcademyUser(tabBarController: UITabBarController){
        
                    let storyboard = UIStoryboard(name: "MyPageStoryboard", bundle: nil)
                    let MyPageVC = storyboard.instantiateViewController(withIdentifier: "AcademyMyPageViewController") as! AcademyMyPageViewController
                    let MyPageNV = UINavigationController.init(rootViewController: MyPageVC)
                    var allviews = tabBarController.viewControllers
                    allviews?.remove(at: 3)
                    allviews?.insert(MyPageNV, at: 3)
                    tabBarController.setViewControllers(allviews, animated: true)
        
        tabBarController.tabBar.items?[3].selectedImage = #imageLiteral(resourceName: "coolicon301").withRenderingMode(.alwaysOriginal).withTintColor(.mainPink)
        tabBarController.tabBar.items?[3].image = #imageLiteral(resourceName: "coolicon301").withRenderingMode(.alwaysOriginal).withTintColor(UIColor(hex: 0xB2B2B2))
        tabBarController.tabBar.items?[3].title = "MyPage"
               
            }
    
    //학원 유저 로그인 - 라이크 탭에서 등록 탭으로 변경
    func changeToEnrollTab(tabBarController: UITabBarController){
        
                    let storyboard = UIStoryboard(name: "LikeStoryboard", bundle: nil)
                    let EnrollVC = storyboard.instantiateViewController(withIdentifier: "EnrollViewController") as! EnrollViewController
                    let EnrollNV = UINavigationController.init(rootViewController: EnrollVC)
                    var allviews = tabBarController.viewControllers
        
        
                    allviews?.remove(at: 2)
                    allviews?.insert(EnrollNV, at: 2)
       
        
                    tabBarController.setViewControllers(allviews, animated: true)
                    
                   
        tabBarController.tabBar.items?[2].selectedImage = #imageLiteral(resourceName: "enroll").withRenderingMode(.alwaysOriginal)
        tabBarController.tabBar.items?[2].image = #imageLiteral(resourceName: "enroll").withRenderingMode(.alwaysOriginal).withTintColor(UIColor(hex: 0xB2B2B2))
        tabBarController.tabBar.items?[2].title = "Enroll"
        
            }


    @IBAction func loginButtonAction(_ sender: Any) {
        
        loginInput.userEmail = emailTextField.text!
        loginInput.userPWD = passwordTextField.text!
        
        if autoLoginButton.isSelected{
            let userDefaults = UserDefaults.standard
            userDefaults.setValue(loginInput.userEmail, forKey: "ID")
            userDefaults.setValue(loginInput.userPWD, forKey: "PW")
             
            print(userDefaults.value(forKey: "ID"))
            print("autologin~")
            UserDefaults.standard.synchronize() // setValue 실행
            
        } else {
            let userDefaults = UserDefaults.standard
            userDefaults.removeObject(forKey: "ID")
            userDefaults.removeObject(forKey: "PW")
             
            UserDefaults.standard.synchronize()
        }
        
        if saveIDButton.isSelected{
            let userDefaults = UserDefaults.standard
            userDefaults.setValue(loginInput.userEmail, forKey: "savedID")
             
            UserDefaults.standard.synchronize() // setValue 실행
            
        } else {
            let userDefaults = UserDefaults.standard
            userDefaults.removeObject(forKey: "savedID")

            UserDefaults.standard.synchronize()
        }
        
        print(loginInput)
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
            KeyCenter.header  = ["X-ACCESS-TOKEN": "\(KeyCenter.LOGIN_TOKEN)"]
            
            
            if result.result?.유저타입 == "일반 유저"{
                KeyCenter.userType = "general"
                changeToGeneralUser(tabBarController: self.tabBarController!)
            }else if result.result?.유저타입 == "학원유저"{
                KeyCenter.userType = "academy"
                
               
                changeToEnrollTab(tabBarController: self.tabBarController!)
                changeToAcademyUser(tabBarController: self.tabBarController!)
                
            
               
                
            }
            print(KeyCenter.userType)
            
        }else{
            self.presentAlert(title: result.message)
            
        }
    
    }
    
    func failedToRequest(){
        
        self.presentAlert(title: "서버와의 연결이 원활하지 않습니다")
    
    }
    
    
}

