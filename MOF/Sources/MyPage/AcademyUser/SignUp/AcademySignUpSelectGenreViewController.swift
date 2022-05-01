//
//  AcademySignUpSelectGenreViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/01/18.
//
import PhotosUI
import UIKit
class AcademySignUpSelectGenreViewController : UIViewController{
    
    lazy var dataManager = AcademyMyPageDataManager()
    
    let picker = UIImagePickerController()
    var imageInput = UIImage()
    var signUpInput = AcademySignUpRequest(image: "", academyEmail: "", academyPWD: "", academyName: "", academyPhone: "", academyDetailAddress: "", academyAddress: "", academyBuilding: "", academyGernre: "")
    
    lazy var buttonList = [kpopButton,coreoButton,hiphopButton,girlsHiphopButton,waakingButton,popinButton,rockingButton,crumpButton,voguingButton,houseButton]
    
    
    var clickedAcademyList = [Int]()
    var academyInput = [String]()
    
    var academyString = ""
    
    @IBOutlet weak var AcademyImageView: UIImageView!
    @IBOutlet weak var cameraButton: UIButton!
    
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
    
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        print(self.signUpInput)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        settingBackButton()
        nextButton.isEnabled = false
        nextButton.backgroundColor = #colorLiteral(red: 0.808078289, green: 0.8075512052, blue: 0.829269588, alpha: 1)
        setButtonLayout()
        picker.delegate = self
      
    }
    
    //MARK:- FUNCTION
    func setButtonLayout(){
        
        kpopButton.layer.cornerRadius = 20
        coreoButton.layer.cornerRadius = 20
        hiphopButton.layer.cornerRadius = 20
        girlsHiphopButton.layer.cornerRadius = 20
        waakingButton.layer.cornerRadius = 20
        popinButton.layer.cornerRadius = 20
        rockingButton.layer.cornerRadius = 20
        crumpButton.layer.cornerRadius = 20
        voguingButton.layer.cornerRadius = 20
        houseButton.layer.cornerRadius = 20
        
        nextButton.layer.cornerRadius = 17.5
        
    }
    
    func checkGenreSelected(){
        if clickedAcademyList.isEmpty == false{
            nextButton.isEnabled = true
            nextButton.backgroundColor = .mainPink
        }else{
            nextButton.isEnabled = false
            nextButton.backgroundColor = #colorLiteral(red: 0.808078289, green: 0.8075512052, blue: 0.829269588, alpha: 1)
        }
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
            buttonList[index]!.layer.backgroundColor = #colorLiteral(red: 1, green: 0, blue: 0.7033678889, alpha: 1)
            clickedAcademyList.append(index)
            clickedAcademyList.sort()
            checkGenreSelected()
            print(clickedAcademyList)
            
        }else{
            buttonList[index]!.layer.backgroundColor = #colorLiteral(red: 0.9436354041, green: 0.9436575174, blue: 0.9436456561, alpha: 1)
            clickedAcademyList.removeAll(where: { $0 == index })
            checkGenreSelected()
            print(clickedAcademyList)
        }
        
    }
    
    
    @IBAction func signUpButtonAction(_ sender: Any) {
        
        for i in 0...9{
            if clickedAcademyList.contains(i){
                academyInput.append(Constant.GenreList[i])
            }
        
        }
        
        for i in academyInput{
            
            if academyString == ""{
                academyString = i
            }else{
                academyString = academyString + ", " + i
            }
            
           
        }
        
        
        signUpInput.academyGernre = academyString
        
        print(signUpInput)
        
        dataManager.academy(signUpInput,imageInput: self.imageInput,delegate: self)
        
        
        
        
    }
    
    
    
    
}

//MARK: -
extension  AcademySignUpSelectGenreViewController : UIImagePickerControllerDelegate & UINavigationControllerDelegate{
    
    func openlibrary(){
        picker.sourceType = .photoLibrary
        picker.modalPresentationStyle = .fullScreen
        picker.allowsEditing = true
        present(picker, animated: true)
        
        
    }
    
    func imagePickerController(_ picker : UIImagePickerController, didFinishPickingMediaWithInfo info : [UIImagePickerController.InfoKey : Any]){
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            
            
            AcademyImageView.image = image
            imageInput = image
            
            self.dismiss(animated: true, completion: nil)
            
        }
    
    }
    
    
    
}

//MARK: - API
extension AcademySignUpSelectGenreViewController{
    
    
    func academy(result : academySignUpResponse){
        print(result)
        if result.isSuccess{
            print(result)
            
        
            
            let welcomeVC = self.storyboard?.instantiateViewController(withIdentifier: "AcademyWelcomViewController") as! AcademyWelcomViewController
            welcomeVC.welcomeText = signUpInput.academyName + "님, 안녕하세요!"
            welcomeVC.welcomImage = imageInput
            self.navigationController?.pushViewController(welcomeVC, animated: true)
            welcomeVC.presentAlert(title: "회원가입이 완료되었습니다")
            
            academyInput.removeAll()
            
            
        }else{
            self.presentAlert(title: result.message)
            
        }
    
    }
    
    func failedToRequest(){
        
        self.presentAlert(title: "서버와의 연결이 원활하지 않습니다")
    
    }
    
    
}


