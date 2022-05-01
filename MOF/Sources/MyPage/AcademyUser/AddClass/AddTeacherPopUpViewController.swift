//
//  AddTeacherPopUpViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/01/06.
//

import UIKit
import PhotosUI
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
        dismissKeyboardWhenTappedAround()
      

    }
    
    //MARK: - FUNCTION
    @IBAction func closeButtonAction(_ sender: Any) {
        
        self.dismiss(animated: false)
    }
    
    @IBAction func addTeacherImageButtonAction(_ sender: Any) {
        if #available(iOS 14, *) {
            if PHPhotoLibrary.authorizationStatus() == .authorized || PHPhotoLibrary.authorizationStatus() == .limited {
                //1. 허용된 상태
                DispatchQueue.main.async {
                    self.openlibrary()
                }
            }else if PHPhotoLibrary.authorizationStatus() == .denied{
                //2. 허용안된 상태
                DispatchQueue.main.async {
                    self.showAuthorizationAlert()
                }
            } else if PHPhotoLibrary.authorizationStatus() == .notDetermined{
                //3. notdetermined: 물어보지 않은 상태
                //info.plist에서 설정
                PHPhotoLibrary.requestAuthorization { status in
                    //클로저 상태안에서 호출하면 쓰레드가 하나 생기는데 이쓰레드에서 checkPermission 호출하면 오류가 난다 그래서 dispatchqueue.main.async로 해야된다
                  
                }
                
            }
        } else {
            // Fallback on earlier versions
        }
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


