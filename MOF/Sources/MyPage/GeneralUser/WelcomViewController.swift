//
//  WelcomViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/01/08.
//

import UIKit
import PhotosUI
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
    var imageInput = UIImage()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        WelcomLabel.text = welcomeText
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        profileImageView.layer.cornerRadius = 100
        skipOrSaveButton.layer.cornerRadius = 22
        
    }
    
    //MARK : - FUNCTION
    
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func GalleryButtonAction(_ sender: Any) {
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
    
    @IBAction func SkipOrSaveButtonAction(_ sender: Any) {
        if isSkip{
            self.dismiss(animated: false)
            
        }else{
//            isSkip = true
//            skipOrSaveButton.setTitle("건너뛰기", for: .normal)
            dataManager.profileImg(profileImage: imageInput, userIndex: self.userIndex, delegate: self)
            
        }
    }
    
}
//MARK: -
extension  WelcomViewController : UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    
    func openlibrary(){
        picker.sourceType = .photoLibrary
        picker.modalPresentationStyle = .fullScreen
        picker.allowsEditing = true
        present(picker, animated: true)
        
        
    }
    
    func imagePickerController(_ picker : UIImagePickerController, didFinishPickingMediaWithInfo info : [UIImagePickerController.InfoKey : Any]){
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            skipOrSaveButton.setTitle("저장하기", for: .normal)
            
            profileImageView.image = image
            imageInput = image
            isSkip = false
            
            self.dismiss(animated: true, completion: nil)
            
        }
    
    }
    
    
    
}

//MARK : - API
extension WelcomViewController{
    
    func profileImg(result : commonResponse){
        if result.isSuccess{
            presentAlert(title: result.message)
            isSkip = true
            skipOrSaveButton.setTitle("로그인 하러가기", for: .normal)
            print("2")
        }else{
            presentAlert(title: result.message)
        }
        
       
    }
    
    func failedToRequest(){
        
        presentAlert(title: "서버와의 연결이 원활하지 않습니다")
        print("3")
        
    }

    
}
