//
//  AddClassViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/01/06.
//

import UIKit
class AddClassViewController : UIViewController{
    
    
    @IBAction func addTeacherButtonAction(_ sender: Any) {
        
        let addTeacherPopUp = self.storyboard?.instantiateViewController(identifier: "AddTeacherPopUpViewController") as! AddTeacherPopUpViewController
        
        self.present(addTeacherPopUp, animated: false, completion: nil)
        
        
        
    }
    
    
    
    
    
    
}
