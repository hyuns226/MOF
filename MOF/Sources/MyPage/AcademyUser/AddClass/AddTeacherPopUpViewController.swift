//
//  AddTeacherPopUpViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/01/06.
//

import UIKit
class AddTeacherPopUpViewController : UIViewController{
    
    let picker = UIImagePickerController()
    var imageInfo = UIImage()
   
    var delegate : teacherInfoProtocol?
    
    @IBOutlet weak var imageButton: UIButton!
    @IBOutlet weak var teacherNameTextField: UITextField!
    @IBOutlet weak var teacherInfoTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        picker.delegate = self
      

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

extension AddTeacherPopUpViewController :  UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    
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


