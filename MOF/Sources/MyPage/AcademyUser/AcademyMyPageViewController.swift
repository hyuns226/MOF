//
//  AcademyMyPageViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/01/06.
//

import UIKit
class AcademyMyPageViewController : UIViewController{
    
    var pageViewController : AcademyPageViewController!
    
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
        addClassButton.layer.cornerRadius = 40
        setButtonList()
        
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
    
    
    @IBAction func regularClassTabAction(_ sender: Any) {
        pageViewController.setViewcontrollersFromIndex(index: 0)
        
    }
    
    @IBAction func onedayClassTabAction(_ sender: Any) {
        pageViewController.setViewcontrollersFromIndex(index: 1)
    }
    
    
    
}
