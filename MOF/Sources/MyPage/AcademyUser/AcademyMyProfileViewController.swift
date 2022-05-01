//
//  academyMyProfileViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/02/09.
//

import Foundation
import UIKit
import PhotosUI
class AcademyMyProfileViewController : UIViewController{
   
    
    lazy var dataManager = AcademyMyPageDataManager()
    
    var clickedAcademyList = [Int]()
    var emailReady = true
    var modifyInput = academyProfileRequest(academyEmail: "", academyName: "", academyPhone: "", academyAddress: "", academyDetailAddress: "",academyBuilding: "", academyGernre: "", profileImgUrl: "")
    
    var genreInput = [String]()
    var genreString = ""
    
    let picker = UIImagePickerController()
   
    lazy var buttonList = [kpopButton,coreoButton,hiphopButton,girlsHiphopButton,waakingButton,popinButton,rockingButton,crumpButton,voguingButton,houseButton]
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var academyNameTextField: UITextField!
    @IBOutlet weak var phoneNumTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var detailAddressTextField: UITextField!
    @IBOutlet weak var emailErrorLabel: UILabel!
    
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
    
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        dataManager.academyProfile(academyIdx: KeyCenter.userIndex, delegate: self)
        setButtonLayout()
        
        picker.delegate = self
        dismissKeyboardWhenTappedAround()
        
        addressTextField.addTarget(self, action: #selector(textFieldTouched), for: .editingDidBegin)
        emailTextField.addTarget(self, action: #selector(limitEmailLengh), for: .editingChanged)
        phoneNumTextField.addTarget(self, action: #selector(LimitePhone), for: .editingChanged)
    }
    
    //MARK:- FUNCTION
    func setButtonLayout(){
        for i in buttonList{
            i!.layer.cornerRadius = 20
            i!.layer.borderWidth = 1
            i!.layer.borderColor = #colorLiteral(red: 0.737254902, green: 0.737254902, blue: 0.737254902, alpha: 1)
            i!.setTitleColor(#colorLiteral(red: 0.3646711111, green: 0.3647280335, blue: 0.3646586537, alpha: 1), for: .normal)
                  
        }
    }
    
    @objc func textFieldTouched(_ textField: UITextField) {
        self.view.endEditing(false)
        let kakaoPostCodeVC = self.storyboard?.instantiateViewController(withIdentifier: "kakaoPostCodeViewController") as!  kakaoPostCodeViewController
        kakaoPostCodeVC.delegate = self
        self.present(kakaoPostCodeVC, animated: true)
    }
    
    @objc func limitEmailLengh(){
        if (emailTextField.text?.count ?? 0 > 50) {
            emailTextField.deleteBackward()
        }
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        if emailTest.evaluate(with: emailTextField.text) == false{
            setTextfieldLayer(textfield : emailTextField)
            emailErrorLabel.isHidden = false
            emailReady = false
        }else{
            emailTextField.layer.borderWidth = 0
            emailErrorLabel.isHidden = true
            emailReady = true
        }
    }
    
    @objc func LimitePhone(){
        if (phoneNumTextField.text?.count ?? 0 > 12) {
            phoneNumTextField.deleteBackward()
        }
    }
    
    func setTextfieldLayer(textfield : UITextField){
        textfield.layer.borderWidth = 1
        textfield.layer.borderColor = UIColor.mainPink.cgColor
    }
    
    @IBAction func cameraButtonAction(_ sender: Any) {
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
        picker.allowsEditing = true
        present(picker, animated: true)
        
    }
    
    @IBAction func saveButtonAction(_ sender: Any) {
        
        setGenreInput()
        
        let filteredArray = [emailTextField,academyNameTextField,phoneNumTextField,addressTextField,detailAddressTextField].filter { $0?.text == "" }
       if (filteredArray.isEmpty) && genreString != "" && emailReady{
           
            modifyInput.academyEmail = emailTextField.text!
            modifyInput.academyName = academyNameTextField.text!
            modifyInput.academyPhone = phoneNumTextField.text!
            modifyInput.academyBuilding = detailAddressTextField.text!
           
            modifyInput.academyGernre = genreString
            print(genreString)
            dataManager.academyProfileModify(modifyInput, imageInput: profileImageView.image, academyIdx: KeyCenter.userIndex, delegate: self)
            
       }else if (filteredArray.isEmpty)==false || genreString == ""  {
             
            presentAlert(title: "비어있는 정보가 있습니다. 모든 정보를 작성해주세요")
            
       }else if emailReady==false{
           presentAlert(title: "이메일 형식을 확인해주시요")
       }
       
    }
    
    func setGenreInput(){
        for i in 0...9{
            if clickedAcademyList.contains(i){
                genreInput.append(Constant.GenreList[i])
            }
        
        }
        
        for i in genreInput{
            
            if genreString == ""{
                genreString = i
            }else{
                genreString = genreString + ", " + i
            }
            
           
        }
        
    }
    
    //강의 장르 버튼 선택 동작
    @IBAction func genreButtonAction(_ sender: UIButton) {
        switch sender.tag{
        case 1 :
           
            GenrebuttonClicked(index : sender.tag-1)
            
            break
        case 2 :
            GenrebuttonClicked(index : sender.tag-1)
            break
         
        case 3 :
            GenrebuttonClicked(index : sender.tag-1)
            break
        case 4 :
            GenrebuttonClicked(index : sender.tag-1)
            break
        case 5 :
            GenrebuttonClicked(index : sender.tag-1)
            break
        case 6 :
            GenrebuttonClicked(index : sender.tag-1)
            break
        case 7 :
            GenrebuttonClicked(index : sender.tag-1)
            break
        case 8 :
            GenrebuttonClicked(index : sender.tag-1)
            break
        case 9 :
            GenrebuttonClicked(index : sender.tag-1)
            break
        case 10:
            GenrebuttonClicked(index : sender.tag-1)
            break
        default:
            print("")
        
            }
        }
    
    
    func GenrebuttonClicked(index : Int){
         buttonList[index]!.isSelected = !buttonList[index]!.isSelected
         if buttonList[index]!.isSelected{
            buttonList[index]?.layer.borderColor = #colorLiteral(red: 0.9450980392, green: 0.0862745098, blue: 0.6862745098, alpha: 1)
            buttonList[index]?.setTitleColor(#colorLiteral(red: 0.9450980392, green: 0.0862745098, blue: 0.6862745098, alpha: 1), for: .selected)
            
             clickedAcademyList.append(index)
             clickedAcademyList.sort()
            print(clickedAcademyList)
             
         }else{
            buttonList[index]?.layer.borderColor = #colorLiteral(red: 0.737254902, green: 0.737254902, blue: 0.737254902, alpha: 1)
            buttonList[index]?.setTitleColor(#colorLiteral(red: 0.3646711111, green: 0.3647280335, blue: 0.3646586537, alpha: 1), for: .normal)
            
             clickedAcademyList.removeAll(where: { $0 == index })
            print(clickedAcademyList)
         }
         
     }
    
    
}

//MARK:- EXTENSION

//MARK:- IMAGE PICKER
extension AcademyMyProfileViewController : UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    func imagePickerController(_ picker : UIImagePickerController, didFinishPickingMediaWithInfo info : [UIImagePickerController.InfoKey : Any]){
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
        
            profileImageView.image = image
         
            
            self.dismiss(animated: true, completion: nil)
            
        }
    
    }
    
    
}

//MARK:- API

extension AcademyMyProfileViewController {
    
    func academyProfile(result : academyProfileResponse){
        if result.isSuccess{
            
            if let url = URL(string: result.result.academyBackImgUrl ?? "") {
                profileImageView.kf.setImage(with: url)
            } else {
                profileImageView.image = UIImage(named: "defaultImage")
            }
            
            emailTextField.text = result.result.academyEmail
            academyNameTextField.text = result.result.academyName
            phoneNumTextField.text = result.result.academyPhone
            addressTextField.text = result.result.academyDetailAddress
            detailAddressTextField.text = result.result.academyBuilding
            
           
            //장르 string 잘라서 배열로
            let filterdGenreList = String(result.result.academyGernre.filter { !" ".contains($0) }).components(separatedBy: ",")
            
            //장르 인덱스 저장
            for i in filterdGenreList{
                clickedAcademyList.append(Constant.GenreList.firstIndex(of: i) ?? 0)
                
            }
           
            for i in filterdGenreList{
                
                let genreIdx = Constant.GenreList.firstIndex(of: "\(i)")

                buttonList[genreIdx ?? 0]?.isSelected = true
                buttonList[genreIdx ?? 0]?.layer.borderColor = #colorLiteral(red: 0.9450980392, green: 0.0862745098, blue: 0.6862745098, alpha: 1)
                buttonList[genreIdx ?? 0]?.setTitleColor(#colorLiteral(red: 0.9450980392, green: 0.0862745098, blue: 0.6862745098, alpha: 1), for: .selected)
                
            }
            
            modifyInput = academyProfileRequest(academyEmail: result.result.academyEmail, academyName: result.result.academyName, academyPhone: result.result.academyPhone, academyAddress: result.result.academyAddress, academyDetailAddress: result.result.academyDetailAddress, academyBuilding: result.result.academyBuilding ?? "", academyGernre: result.result.academyGernre, profileImgUrl: result.result.academyBackImgUrl ?? "")
            
            
        }else{
            
            presentAlert(title:  result.message)
            
        }
    
        
    }
    
    func profileModify(result : regularResponse){
        if result.isSuccess{
            presentAlert(title:  "저장 되었습니다.")
            
        }else{
            presentAlert(title:  result.message)
        }
        
        
    }
    
    
    func failedToRequest(){
        
        self.presentAlert(title: "서버와의 연결이 원활하지 않습니다")

    }

}

extension AcademyMyProfileViewController : kakaoPostCodeProtocol{
    func sendPostCode(forShow: String, forSend: String, addressForSearch : String) {
        addressTextField.text = forShow
        modifyInput.academyDetailAddress = forSend
        modifyInput.academyAddress = addressForSearch
    }

}
