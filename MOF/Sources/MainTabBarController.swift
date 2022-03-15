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
        
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.clipsToBounds = true
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
   }
    
   
}
