//
//  EnrollViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/03/11.
//

import Foundation
import UIKit
class EnrollViewController : UIViewController{
    var pageViewController : EnrollPageViewController!
    
    @IBOutlet weak var RegularTabButton: UIButton!
    @IBOutlet weak var OnedayTabButton: UIButton!
  
    
    var buttonLists : [UIButton] = []
    
    var currentIndex : Int = 0 {
        didSet {
            changeButtonColor()
            
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.topItem?.title = "수강 신청 내역"
        setButtonList()
    
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
    }
    
    //MARK: - Function
    
    
    
    func setButtonList() {
        buttonLists.append(RegularTabButton)
        buttonLists.append(OnedayTabButton)
        
        RegularTabButton.tintColor = #colorLiteral(red: 0.9450980392, green: 0, blue: 0.6862745098, alpha: 1)
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
        
        if segue.identifier == "EnrollPageViewController" {
            guard let vc = segue.destination as? EnrollPageViewController else {return}
            pageViewController = vc
            
            pageViewController.completeHandler = { (result) in
                self.currentIndex = result
            }
        }
    }
    
    @IBAction func RegularTabAction(_ sender: UIButton) {
        pageViewController.setViewcontrollersFromIndex(index: 0)
    }
    
    @IBAction func OnedayTabAction(_ sender: UIButton) {
        pageViewController.setViewcontrollersFromIndex(index: 1)
    }
    
}
    
    

