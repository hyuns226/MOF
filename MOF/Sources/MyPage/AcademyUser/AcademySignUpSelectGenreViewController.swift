//
//  AcademySignUpSelectGenreViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/01/18.
//

import UIKit
class AcademySignUpSelectGenreViewController : UIViewController{
    
    lazy var dataManager = AcademyMyPageDataManager()
    
    var signUpInput = AcademySignUpRequest(image: "", academyEmail: "", academyPWD: "", academyName: "", academyPhone: "", academyDetailAddress: "", academyAddress: "", academyGernre: "")
    
    lazy var buttonList = [kpopButton,coreoButton,hiphopButton,girlsHiphopButton,waakingButton,popinButton,rockingButton,crumpButton,voguingButton,houseButton]
    
    var genreList = ["K-POP","코레오","힙합","걸스힙합","왁킹","팝핀","락킹","크럼프","보깅","하우스"]
    
    
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
        
        setButtonLayout()
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
            
        }else{
            buttonList[index]!.layer.backgroundColor = #colorLiteral(red: 0.9436354041, green: 0.9436575174, blue: 0.9436456561, alpha: 1)
            clickedAcademyList.removeAll(where: { $0 == index })
        }
         
    
        
        
    }
    
    
    @IBAction func signUpButtonAction(_ sender: Any) {
        
        for i in 0...9{
            if clickedAcademyList.contains(i){
                academyInput.append(genreList[i])
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
        
        dataManager.academy(signUpInput, delegate: self)
        
        academyInput.removeAll()
        
        
    }
    
    
    
    
}

//MARK: - API
extension AcademySignUpSelectGenreViewController{
    
    
    func academy(result : academySignUpResponse){
        if result.isSuccess == true{
            print(result)
            
           //유저아이디
            
            
            self.dismiss(animated: false, completion: nil)
            
            let welcomeVC = self.storyboard?.instantiateViewController(withIdentifier: "AcademyWelcomViewController") as! AcademyWelcomViewController
            
            self.present(welcomeVC,animated: false)
            
            
        }else{
            self.presentAlert(title: result.message)
            
        }
    
    }
    
    func failedToRequest(){
        
        self.presentAlert(title: "서버와의 연결이 원활하지 않습니다")
    
    }
    
    
}


