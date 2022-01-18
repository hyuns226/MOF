//
//  SIgnUpViewController.swift
//  MOF
//
//  Created by 이현서 on 2021/12/30.
//

import UIKit
class SIgnInViewController : UIViewController{
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBOutlet weak var loginButton: UIButton!
    
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
