//
//  CustomTabBarController.swift
//  MOF
//
//  Created by 이현서 on 2022/01/06.
//

import UIKit
class MainTabBarController : UITabBarController{
     
     override func viewDidLoad() {
        
        super.viewDidLoad()
        
         print("MainTabBarControllerviewdidload")
         autoLogin()
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.clipsToBounds = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
         

        
   }
    
    //MARK:- FUNCTION
    func autoLogin(){
        print("in func autologin")
        // 값이 저장되어있다면 자동 로그인
              if let userId = UserDefaults.standard.string(forKey: "ID"){
    
                if let userPW = UserDefaults.standard.string(forKey: "PW"){
                    
                    print("자동 로그인 시작")
                    UserMyPageDataManager().autoLogin(loginRequest(userEmail: userId, userPWD: userPW), delegate: self)

                }else{
                    print("비번 저장 안됨")
                }
        
        
              }else{
                print("아이디 저장 안됨")
              }
    }
    
    
   
}

extension MainTabBarController{
    func login(result : loginResponse){
        if result.isSuccess == true{
            print(result)
            
            KeyCenter.userIndex = result.result!.userIdx
            KeyCenter.LOGIN_TOKEN = result.result!.jwt
            KeyCenter.header  = ["X-ACCESS-TOKEN": "\(KeyCenter.LOGIN_TOKEN)"]
            
            
            if result.result?.유저타입 == "일반 유저"{
                KeyCenter.userType = "general"
                changeToGeneralUser(tabBarController: self)
            }else if result.result?.유저타입 == "학원유저"{
                KeyCenter.userType = "academy"
                
               
                changeToEnrollTab(tabBarController: self)
                changeToAcademyUser(tabBarController: self)
                
            }
            print(KeyCenter.userType)
            
        }else{
            print(result.message)
            
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

}

