//
//  DetailSearchViewController.swift
//  MOF
//
//  Created by 이현서 on 2021/10/27.
//

import UIKit
class DetailSearchViewController : UIViewController{
    
    var pageViewController : DetailSearchPageViewController!
    
    @IBOutlet weak var KpopTabButton: UIButton!
    @IBOutlet weak var CoreoTabButton: UIButton!
    @IBOutlet weak var HiphopTabButton: UIButton!
    @IBOutlet weak var GirlsHiphopTabButton: UIButton!
    @IBOutlet weak var WaackingTabButton: UIButton!
    
    var buttonLists : [UIButton] = []
    
    var currentIndex : Int = 0 {
        didSet {
            changeButtonColor()
            
        }
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        setButtonList()
    }
    
    //MARK:- Function
    
    func setButtonList() {
        buttonLists.append(KpopTabButton)
        buttonLists.append(CoreoTabButton)
        buttonLists.append(HiphopTabButton)
        buttonLists.append(GirlsHiphopTabButton)
        buttonLists.append(WaackingTabButton)
        
        KpopTabButton.tintColor = #colorLiteral(red: 0.0862745098, green: 0.0862745098, blue: 0.0862745098, alpha: 1)
        CoreoTabButton.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
        HiphopTabButton.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
        GirlsHiphopTabButton.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
        WaackingTabButton.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
        
     
    }
    
    func changeButtonColor() {
        for (index, element) in buttonLists.enumerated() {
            if index == currentIndex {
                element.tintColor = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
            }
            else {
                element.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DetailSearchPageViewController" {
            guard let vc = segue.destination as? DetailSearchPageViewController else {return}
            pageViewController = vc
            
            pageViewController.completeHandler = { (result) in
                self.currentIndex = result
            }
        }
    }
    
    @IBAction func AllTabAction(_ sender: Any) {
        pageViewController.setViewcontrollersFromIndex(index: 0)
    }
    
    @IBAction func ShoesTabAction(_ sender: Any) {
        pageViewController.setViewcontrollersFromIndex(index: 1)
    }
    
    @IBAction func ClothesTabAction(_ sender: Any) {
        pageViewController.setViewcontrollersFromIndex(index: 2)
    }
    @IBAction func LeatherTabAction(_ sender: Any) {
        pageViewController.setViewcontrollersFromIndex(index: 3)
    }
    @IBAction func UpcyclingTabAction(_ sender: Any) {
        pageViewController.setViewcontrollersFromIndex(index: 4)
        
    }
}

    
    
    
    

