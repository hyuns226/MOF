//
//  WelcomViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/01/08.
//

import UIKit
class WelcomViewController : UIViewController {
    
    let picker = UIImagePickerController()
    let dataManager = UserMyPageDataManager()
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var galleryButton: UIButton!
    @IBOutlet weak var WelcomLabel: UILabel!
    @IBOutlet weak var skipOrSaveButton: UIButton!
    
    var welcomeText = ""
    var userIndex = -1
    var isSkip = true
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        WelcomLabel.text = welcomeText
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        
        profileImageView.layer.cornerRadius = 100
        skipOrSaveButton.layer.cornerRadius = 17.5
        
    }
    
    //MARK : - FUNCTION
    
    
    @IBAction func GalleryButtonAction(_ sender: Any) {
        openlibrary()
    }
    
    @IBAction func SkipOrSaveButtonAction(_ sender: Any) {
//        if isSkip{
//            //마이페이지 or 로그인페이지로 넘어감
//        }else{
//
//            //저장하기, api연동 해서 저장
//            dataManager.profileImg(userProfileImageRequest(image: #imageLiteral(resourceName: "checkBoxSelected").jpegData(compressionQuality: 1.0)!), userIndex: KeyCenter.userIndex, delegate: self)
//
//        }
//
        
        dataManager.profileImg(userProfileImageRequest(image: #imageLiteral(resourceName: "checkBoxSelected").jpegData(compressionQuality: 1.0)!), userIndex: KeyCenter.userIndex, delegate: self)
        print("1")
    }
    
}
//MARK: -
extension  WelcomViewController : UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    
    func openlibrary(){
        picker.sourceType = .photoLibrary
        picker.modalPresentationStyle = .fullScreen
        present(picker, animated: true)
        
        
    }
    
    func imagePickerController(_ picker : UIImagePickerController, didFinishPickingMediaWithInfo info : [UIImagePickerController.InfoKey : Any]){
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            skipOrSaveButton.setTitle("저장하기", for: .normal)
            
            profileImageView.image = image
            isSkip = false
            
            self.dismiss(animated: true, completion: nil)
            
        }
    
    }
    
    
    
}

//MARK : - API
extension WelcomViewController{
    
    func profileImg(result : commonResponse){
        
        presentAlert(title: result.message)
        print("2")
    }
    
    func failedToRequest(){
        
        
        presentAlert(title: "서버와의 연결이 원활하지 않습니다")
        print("3")
        
    }

    
}
