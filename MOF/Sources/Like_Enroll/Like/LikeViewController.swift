//
//  LikeViewController.swift
//  MOF
//
//  Created by 이현서 on 2021/12/02.
//

import UIKit

class LikeViewController : UIViewController{
    
    static var isFitered = false
    static var filterText = ""
    
    var pageViewController : LikePageViewController!
    
    @IBOutlet weak var AcademyTabButton: UIButton!
    @IBOutlet weak var ClassTabButton: UIButton!
  
    
    var buttonLists : [UIButton] = []
    
    var currentIndex : Int = 0 {
        didSet {
            changeButtonColor()
            
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
        //navigationController?.setNavigationBarHidden(true, animated: animated)
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingTabBar()
        setButtonList()
    
    }
    
    //MARK: - Function
    
    func settingTabBar(){
        self.tabBarController?.tabBar.items?[2].selectedImage = #imageLiteral(resourceName: "coolicon_288").withRenderingMode(.alwaysOriginal)
        self.tabBarController?.tabBar.items?[2].image = #imageLiteral(resourceName: "coolicon300").withRenderingMode(.alwaysOriginal).withTintColor(UIColor(hex: 0xB2B2B2))
        self.tabBarController?.tabBar.items?[2].title = "Like"
    }
    
    
    func setButtonList() {
        buttonLists.append(AcademyTabButton)
        buttonLists.append(ClassTabButton)
        
        AcademyTabButton.tintColor = #colorLiteral(red: 0.9450980392, green: 0, blue: 0.6862745098, alpha: 1)
        ClassTabButton.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
     
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
        
        if segue.identifier == "LikePageViewController" {
            guard let vc = segue.destination as? LikePageViewController else {return}
            pageViewController = vc
            
            pageViewController.completeHandler = { (result) in
                self.currentIndex = result
            }
        }
    }
    
    @IBAction func AcademyTabAction(_ sender: UIButton) {
        pageViewController.setViewcontrollersFromIndex(index: 0)
    }
    
    @IBAction func ClassTabAction(_ sender: UIButton) {
        pageViewController.setViewcontrollersFromIndex(index: 1)
    }
    
}



    
    
    
    

