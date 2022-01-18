//
//  AcademySignUpViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/01/18.
//

import UIKit
class AcademySignUpViewController : UIViewController{
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var checkPassWordTextField: UITextField!
    @IBOutlet weak var academyNameTextField: UITextField!
    @IBOutlet weak var selectAddressButton: UIButton!
    @IBOutlet weak var detailAddressTextField: UITextField!
    @IBOutlet weak var phoneNumTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//MARK:- FUCTION
    @IBAction func nextButtonAction(_ sender: Any) {
    }
    
}


