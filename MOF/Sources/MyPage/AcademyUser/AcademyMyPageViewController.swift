//
//  AcademyMyPageViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/01/06.
//

import UIKit
class AcademyMyPageViewController : UIViewController{
    
    var pageViewController : AcademyPageViewController!
    var dataManager = AcademyMyPageDataManager()
    
    static var deleteAlertFlag = 0
    var alertFlag = 0
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var showProfileButton: UIButton!
  
    
    @IBOutlet weak var regularClassTab: UIButton!
    @IBOutlet weak var onedayClassTab: UIButton!
    @IBOutlet weak var addClassButton: UIButton!
    
    var buttonLists : [UIButton] = []
    
    var currentIndex : Int = 0 {
        didSet {
            changeButtonColor()
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        setButtonList()
        addClassButton.layer.cornerRadius = 40
        showProfileButton.layer.cornerRadius = 14
        settingBackButton()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        self.navigationController?.navigationBar.isHidden = true
        
        //change status bar color to light
        UIApplication.shared.statusBarStyle = .lightContent
        dataManager.academyProfileForMain(academyIdx: KeyCenter.userIndex, delegate: self)
        
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        self.navigationController?.navigationBar.isHidden = false
        //change status bar color to original
        UIApplication.shared.statusBarStyle = .darkContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if alertFlag == 1{
            self.presentAlert(title: "수업이 정상적으로 등록되었습니다.")
            alertFlag = 0
        }
        
        if AcademyMyPageViewController.deleteAlertFlag == 1{
            self.presentAlert(title: "수업이 정상적으로 삭제되었습니다.")
            AcademyMyPageViewController.deleteAlertFlag = 0
        }
    }
    
    
    
    //MARK:- FUNCTION
    func setButtonList() {
        buttonLists.append(regularClassTab)
        buttonLists.append(onedayClassTab)
       
        
        regularClassTab.tintColor = #colorLiteral(red: 0.9671199918, green: 0.2031135857, blue: 0.7404999137, alpha: 1)
        onedayClassTab.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
       
    }
    
    func changeButtonColor() {
        for (index, element) in buttonLists.enumerated() {
            if index == currentIndex {
                element.tintColor = #colorLiteral(red: 0.9671199918, green: 0.2031135857, blue: 0.7404999137, alpha: 1)
            }
            else {
                element.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "AcademyPageViewController" {
            guard let vc = segue.destination as? AcademyPageViewController else {return}
            pageViewController = vc
            
            pageViewController.completeHandler = { (result) in
                self.currentIndex = result
            }
        }
    }
    
    @IBAction func setProfileButtonAction(_ sender: Any) {
        let profileVC = self.storyboard?.instantiateViewController(withIdentifier: "AcademyMyProfileViewController")as!AcademyMyProfileViewController
        
        self.navigationController?.pushViewController(profileVC, animated: true)
    }
    
    @IBAction func settingButtonAction(_ sender: Any) {
        let settingVC = self.storyboard?.instantiateViewController(withIdentifier: "AcademySettingViewController")as!AcademySettingViewController
        
        self.navigationController?.pushViewController(settingVC, animated: true)
    }
    
    @IBAction func changeProfileImgButtonAction(_ sender: Any) {
    }
    
    @IBAction func regularClassTabAction(_ sender: Any) {
        pageViewController.setViewcontrollersFromIndex(index: 0)
        
    }
    
    @IBAction func onedayClassTabAction(_ sender: Any) {
        pageViewController.setViewcontrollersFromIndex(index: 1)
    }
    
    
    @IBAction func addClassButtonAction(_ sender: Any) {
        let addClassVC = self.storyboard?.instantiateViewController(withIdentifier: "AddClassViewController")as!AddClassViewController
        addClassVC.delegate = self
        addClassVC.modalPresentationStyle = .fullScreen
        present(addClassVC, animated: true, completion: nil)
    }
    
    
}

//MARK:- API
extension AcademyMyPageViewController{
    func academyProfileForMain(result : academyProfileResponse){
        
        
        print(result)
        
        if result.isSuccess{
            print(result)
       
            nameLabel.text = result.result.academyName + "학원"
            
            if let url = URL(string: result.result.academyBackImgUrl ?? "") {
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


//MARK:-Protocol
extension AcademyMyPageViewController : addClassAlertProtocol{
    
    func showAlert() {
        alertFlag = 1
        
    }
    
}


