//
//  CompleteEnrollmentViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/02/24.
//

import Foundation
import UIKit
class CompleteEnrollmentViewController : UIViewController{
    
    var classImage  = UIImage(named: "defaultImage")
    
    @IBOutlet weak var classImageView: UIImageView!
    @IBOutlet weak var goToRegistrationButtonAction: UIButton!
    
    override func viewDidLoad() {
        classImageView.image = classImage
    }
    
    //MARK:- FUNCTION
    
    
    @IBAction func goToClassInfoButtonAction(_ sender: Any) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    @IBAction func goToEnrolledListVC(_ sender: Any) {
        self.dismiss(animated: true)
        tabBarController?.selectedIndex = 3
    }
}
