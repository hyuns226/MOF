//
//  MyPageViewController.swift
//  MOF
//
//  Created by 이현서 on 2021/12/02.
//

import UIKit
class MyPageViewController : UIViewController{
    
    var pageViewController : MyPagePageViewController!
    
   
    
    @IBOutlet weak var RegularClassTabButton: UIButton!
    @IBOutlet weak var OnedayTabButton: UIButton!
    
    
    var buttonLists : [UIButton] = []
    
    var currentIndex : Int = 0 {
        didSet {
            changeButtonColor()
            
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
      
        navigationController?.setNavigationBarHidden(true, animated: animated)
      
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    
    @IBAction func DesignerTabAction(_ sender: UIButton) {
        pageViewController.setViewcontrollersFromIndex(index: 0)
    }
    
    @IBAction func CustomTabAction(_ sender: UIButton) {
        pageViewController.setViewcontrollersFromIndex(index: 1)
    }
    
}

