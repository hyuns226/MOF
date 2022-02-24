//
//  CompleteEnrollmentViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/02/24.
//

import Foundation
import UIKit
class CompleteEnrollmentViewController : UIViewController{
    
    @IBOutlet weak var classImageView: UIImageView!
    
    
    @IBOutlet weak var goToRegistrationButtonAction: UIButton!
    
    @IBAction func goToClassInfoButtonAction(_ sender: Any) {
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}
