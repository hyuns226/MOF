//
//  AppDelegate.swift
//  MOF - storyboard
//
//  Created by 이현서 on 2022/01/13.
//

import UIKit
import AlamofireNetworkActivityIndicator

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        sleep(1)
        print(-1)
        
        
        settingNavigationWhite()
        
        //하단 탭바 선택 되기 전 색 지정
        UITabBar.appearance().unselectedItemTintColor = UIColor { _ in UIColor(hex: 0xB2B2B2) }
        
        // StatusBar에 Alamofire 시도 중 Indicator 띄워주기 위한 옵션 설정
        NetworkActivityIndicatorManager.shared.isEnabled = true
        
       
        
        
        return true
    }
    
    
    
    func settingNavigationWhite(){
        if #available(iOS 13.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UIColor.white
            appearance.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.black
            ]

            let buttonAppearance = UIBarButtonItemAppearance()
            buttonAppearance.normal.titleTextAttributes = [.foregroundColor: UIColor.white]
            appearance.buttonAppearance = buttonAppearance

            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
            UINavigationBar.appearance().compactAppearance = appearance

            UIBarButtonItem.appearance().tintColor = UIColor.white
        } else {
            UINavigationBar.appearance().barTintColor = UIColor.white
            UINavigationBar.appearance().titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.black
            ]
            UINavigationBar.appearance().tintColor = UIColor.white

            UIBarButtonItem.appearance().tintColor = UIColor.white
        }
    }
    

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        print(-2)
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        print(-3)
       
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}



