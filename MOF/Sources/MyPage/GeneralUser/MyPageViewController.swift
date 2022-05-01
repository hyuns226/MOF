//
//  MyPageViewController.swift
//  MOF
//
//  Created by 이현서 on 2021/12/02.
//

import UIKit
import Foundation
class MyPageViewController : UIViewController{
    
    var pageViewController : MyPagePageViewController!
    
   var dataManager = UserMyPageDataManager()
    
    @IBOutlet weak var RegularClassTabButton: UIButton!
    @IBOutlet weak var OnedayTabButton: UIButton!
    
    @IBOutlet weak var nameLabel: UILabel!
   
    @IBOutlet weak var profileImageView: UIImageView!
    
    var buttonLists : [UIButton] = []
    
    var currentIndex : Int = 0 {
        didSet {
            changeButtonColor()
            
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        //change status bar color to light
        UIApplication.shared.statusBarStyle = .lightContent
        
        print(KeyCenter.userIndex
        )
        dataManager.userProfileForMain(userIdx: KeyCenter.userIndex, delegate: self)
        
       
      
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        self.navigationController?.navigationBar.isHidden = false
        //change status bar color to original
        UIApplication.shared.statusBarStyle = .darkContent
    }
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingBackButton()
       
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = .red
        
        profileImageView.layer.cornerRadius
         = 75
        
        setButtonList()
    
    }
    
   
    

    //MARK: - Function
    
    
    
    func setButtonList() {
        buttonLists.append(RegularClassTabButton)
        buttonLists.append(OnedayTabButton)
        
        RegularClassTabButton.tintColor = #colorLiteral(red: 0.9450980392, green: 0, blue: 0.6862745098, alpha: 1)
        OnedayTabButton.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
     
    }
    
    func changeButtonColor() {
        for (index, element) in buttonLists.enumerated() {
            if index == currentIndex {
                element.tintColor = #colorLiteral(red: 0.9450980392, green: 0, blue: 0.6862745098, alpha: 1)
            }
            else {
                element.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "MyPagePageViewController" {
            guard let vc = segue.destination as? MyPagePageViewController else {return}
            pageViewController = vc
            
            pageViewController.completeHandler = { (result) in
                self.currentIndex = result
            }
        }
    }
    @IBAction func showMyProfileButtonAction(_ sender: Any) {
        let myprofileVC = self.storyboard?.instantiateViewController(withIdentifier: "GeneralMyProfileViewController")as!GeneralMyProfileViewController
       
        self.navigationController?.pushViewController(myprofileVC, animated: true)
    }
    
    @IBAction func settingButtonAction(_ sender: Any) {
        let settingVC = self.storyboard?.instantiateViewController(withIdentifier: "GeneralSettingViewController")as!GeneralSettingViewController
        self.navigationController?.pushViewController(settingVC, animated: true)
    }
    
    
    @IBAction func regularClassTabAction(_ sender: UIButton) {
        pageViewController.setViewcontrollersFromIndex(index: 0)
    }
    
    @IBAction func onedayClassTabAction(_ sender: UIButton) {
        pageViewController.setViewcontrollersFromIndex(index: 1)
    }
    
}

//MARK:-API
extension MyPageViewController{
    func userProfile(result : userProfileResponse){
        
        
        print(result)
        
        if result.isSuccess{
            print(result)
       
           nameLabel.text = result.result!.userName + "님"
            
            if let url = URL(string: result.result?.userProfileImgUrl ?? "") {
                profileImageView.kf.setImage(with: url)
            } else {
                profileImageView.image = UIImage(named: "defaultImage")
            }
            
            
        }else{
            presentAlert(title:  result.message)
            
            
        }
        
        
        
        
        
    }


    func failedToRequest(){
        
        presentAlert(title:  "서버와의 연결이 원활하지 않습니다")
    }

}
