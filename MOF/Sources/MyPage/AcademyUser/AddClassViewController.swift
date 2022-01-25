//
//  AddClassViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/01/06.
//

import UIKit
class AddClassViewController : UIViewController{
    
    lazy var buttonList = [kpopButton,coreoButton,hiphopButton,girlsHiphopButton,waakingButton,popinButton,rockingButton,crumpButton,voguingButton,houseButton]
    
    @IBOutlet weak var regularClassButton: UIButton!
    @IBOutlet weak var ondayClassButton: UIButton!
    @IBOutlet weak var classNameTextField: UITextField!
    @IBOutlet weak var classExplainTextView: UITextView!
    @IBOutlet weak var TuitionTextView: UITextField!
    @IBOutlet weak var classMemberNumTextField: UITextField!
    @IBOutlet weak var classStartTimeOneButton: UIButton!
    @IBOutlet weak var classEndTimeOneButton: UIButton!
    @IBOutlet weak var classStartTimeTwoButton: UIButton!
    @IBOutlet weak var classEndTimeTwoButton: UIButton!
    @IBOutlet weak var teacherCollectionView: UICollectionView!
    @IBOutlet weak var classPictureImageView: UIImageView!
    @IBOutlet weak var classPictureDeleteButton: UIButton!
    @IBOutlet weak var classPictureAddButton: UIButton!
    
    @IBOutlet weak var kpopButton: UIButton!
    @IBOutlet weak var coreoButton: UIButton!
    @IBOutlet weak var hiphopButton: UIButton!
    @IBOutlet weak var girlsHiphopButton: UIButton!
    @IBOutlet weak var waakingButton: UIButton!
    @IBOutlet weak var popinButton: UIButton!
    @IBOutlet weak var rockingButton: UIButton!
    @IBOutlet weak var crumpButton: UIButton!
    @IBOutlet weak var voguingButton: UIButton!
    @IBOutlet weak var houseButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK:- FUNCTION
    func setButtonLayout(){
        
        regularClassButton.layer.cornerRadius = 25
        regularClassButton.layer.borderWidth = 1
        regularClassButton.layer.borderColor = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
        
        ondayClassButton.layer.cornerRadius = 25
        ondayClassButton.layer.borderWidth = 1
        ondayClassButton.layer.borderColor = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
        
        classStartTimeOneButton.layer.borderWidth = 1
        classStartTimeOneButton.layer.borderColor = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
        
        classEndTimeOneButton.layer.borderWidth = 1
        classEndTimeOneButton.layer.borderColor = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
        
        classStartTimeTwoButton.layer.borderWidth = 1
        classStartTimeTwoButton.layer.borderColor = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
        
        classEndTimeTwoButton.layer.borderWidth = 1
        classEndTimeTwoButton.layer.borderColor = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
        
        for i in buttonList{
            i!.layer.cornerRadius = 20
            i!.layer.borderWidth = 1
            i!.layer.borderColor = #colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1)
                  
            
        }
    
       
    
        
    }
    
    @IBAction func regularClassButtonAction(_ sender: Any) {
    }
    
    @IBAction func onedayClassButtonAction(_ sender: Any) {
    }
    
    @IBAction func startTimeOneAction(_ sender: Any) {
        
    }
    @IBAction func endTimeTwoAction(_ sender: Any) {
    }
    @IBAction func EndTimeOneAction(_ sender: Any) {
    }
    @IBAction func startTimeTwoAction(_ sender: Any) {
    }
    
    @IBAction func addTeacherButtonAction(_ sender: Any) {
        
        let addTeacherPopUp = self.storyboard?.instantiateViewController(identifier: "AddTeacherPopUpViewController") as! AddTeacherPopUpViewController
        
        self.present(addTeacherPopUp, animated: false, completion: nil)
        
        
        
    }
    
    @IBAction func deleteClassPicture(_ sender: Any) {
    }
    
    @IBAction func addClassPicture(_ sender: Any) {
    }
    
    
    
    
    
    
}
