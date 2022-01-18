//
//  CustomTabViewController.swift
//  MOF
//
//  Created by 이현서 on 2021/10/26.
//

import UIKit
class HomeViewController : UIViewController{
    
    var pageViewController : HomePageViewController!
    
    @IBOutlet weak var KpopTabButton: UIButton!
    @IBOutlet weak var CoreoTabButton: UIButton!
    @IBOutlet weak var HiphopTabButton: UIButton!
    @IBOutlet weak var GirlsHiphopTabButton: UIButton!
    @IBOutlet weak var WaackingTabButton: UIButton!
    @IBOutlet weak var PopinTabButton: UIButton!
    @IBOutlet weak var RockingTabButton: UIButton!
    @IBOutlet weak var CrumpTabButton: UIButton!
    @IBOutlet weak var VoguingTabButton: UIButton!
    @IBOutlet weak var HouseTabButton: UIButton!
    
    var buttonLists : [UIButton] = []
    
    var currentIndex : Int = 0 {
        didSet {
            changeButtonColor()
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonList()
    }
    
    //MARK:- Function
    
    func setButtonList() {
        buttonLists.append(KpopTabButton)
        buttonLists.append(CoreoTabButton)
        buttonLists.append(HiphopTabButton)
        buttonLists.append(GirlsHiphopTabButton)
        buttonLists.append(WaackingTabButton)
        buttonLists.append(PopinTabButton)
        buttonLists.append(RockingTabButton)
        buttonLists.append(CrumpTabButton)
        buttonLists.append(VoguingTabButton)
        buttonLists.append(HouseTabButton)
        
        KpopTabButton.tintColor = #colorLiteral(red: 0.9671199918, green: 0.2031135857, blue: 0.7404999137, alpha: 1)
        CoreoTabButton.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
        HiphopTabButton.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
        GirlsHiphopTabButton.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
        WaackingTabButton.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
        PopinTabButton.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
        RockingTabButton.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
        PopinTabButton.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
        RockingTabButton.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
        CrumpTabButton.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
        VoguingTabButton.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
        HouseTabButton.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
     
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
        
        if segue.identifier == "HomePageViewController" {
            guard let vc = segue.destination as? HomePageViewController else {return}
            pageViewController = vc
            
            pageViewController.completeHandler = { (result) in
                self.currentIndex = result
            }
        }
    }
    
    
    @IBAction func KpopTabAction(_ sender: Any) {
        print("kpop")
        pageViewController.setViewcontrollersFromIndex(index: 0)
        
    }
    @IBAction func CoreoTabAction(_ sender: Any) {
        pageViewController.setViewcontrollersFromIndex(index: 1)
       
    }
    @IBAction func HiphopTabAction(_ sender: Any) {
        print("hiphop")
        pageViewController.setViewcontrollersFromIndex(index: 2)
       
    }
    @IBAction func GirlsHiphopTabAction(_ sender: Any) {
        print("girlshiphop")
        pageViewController.setViewcontrollersFromIndex(index: 3)
        
    }
    @IBAction func WaakingTabAction(_ sender: Any) {
        print("waaking")
        pageViewController.setViewcontrollersFromIndex(index: 4)
       
    }
  
    @IBAction func PopinTabAction(_ sender: Any) {
        print("popin")
        pageViewController.setViewcontrollersFromIndex(index: 5)
        
    }
    
    @IBAction func RockingTabAction(_ sender: Any) {
        print("rocking")
        pageViewController.setViewcontrollersFromIndex(index: 6)
       
    }
    
    @IBAction func CrumpTabAction(_ sender: Any) {
        print("crump")
        pageViewController.setViewcontrollersFromIndex(index: 7)
        
    }
    
    @IBAction func VoguingTabAction(_ sender: Any) {
        print("voguing")
        pageViewController.setViewcontrollersFromIndex(index: 8)
        
    }
    @IBAction func HouseTabAction(_ sender: Any) {
        print("house")
        pageViewController.setViewcontrollersFromIndex(index: 9)
        
    }
    
}
