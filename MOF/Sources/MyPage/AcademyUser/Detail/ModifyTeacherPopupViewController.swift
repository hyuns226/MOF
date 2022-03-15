//
//  ModifyTeacherPopupViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/03/01.
//

import UIKit
import Kingfisher

struct teacherInfo{
    var image : String
    var name : String
    var intro : String
}

class ModifyTeacherPopupViewController : UIViewController{
    
    
    
    var teacherInfomation = teacherInfo(image: "", name: "", intro: "")
    
    let picker = UIImagePickerController()
    var imageInfo = UIImage()
   
    var delegate : teacherInfoProtocol?
    
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var teacherNameTextField: UITextField!
    @IBOutlet weak var teacherInfoTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
      
        if let url = URL(string: teacherInfomation.image ?? "") {
            imageButton.kf.setImage(with: url, for: .normal)
        } else {
            imageButton.setImage(UIImage(named: "defaultImage"), for: .normal)
        }
        teacherNameTextField.text = teacherInfomation.name
        teacherInfoTextView.text = teacherInfomation.intro
        
    }
    
    //MARK: - FUNCTION
    @IBAction func closeButtonAction(_ sender: Any) {
        
        self.dismiss(animated: false)
    }
    
    @IBAction func addTeacherImageButtonAction(_ sender: Any) {
        openlibrary()
    }
    
    func openlibrary(){
        picker.sourceType = .photoLibrary
        picker.modalPresentationStyle = .fullScreen
        present(picker, animated: true)
        
    }
    
    @IBAction func addTeacherButtonAction(_ sender: Any) {
        
        delegate?.sendTeacherInfo(teacherImage: imageInfo, teacherName: teacherNameTextField.text ?? "", teacherIntro: teacherInfoTextView.text)
        self.dismiss(animated: true, completion: nil)
    }
    
    
}

extension ModifyTeacherPopupViewController :  UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    
    func imagePickerController(_ picker : UIImagePickerController, didFinishPickingMediaWithInfo info : [UIImagePickerController.InfoKey : Any]){
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            imageInfo = image
            print(image)
            print(imageInfo)
            imageButton.setImage(image, for: .normal)
            self.dismiss(animated: true, completion: nil)
            
        }
    
    }
    
    
}



