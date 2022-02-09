//
//  academyMyProfileViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/02/09.
//

import Foundation
import UIKit
class AcademyMyProfileViewController : UIViewController{
    
    lazy var dataManager = AcademyMyPageDataManager()
    
    lazy var buttonList = [kpopButton,coreoButton,hiphopButton,girlsHiphopButton,waakingButton,popinButton,rockingButton,crumpButton,voguingButton,houseButton]
    
    var genreList = ["K-POP","코레오","힙합","걸스힙합","왁킹","팝핀","락킹","크럼프","보깅","하우스"]
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var academyNameTextField: UITextField!
    @IBOutlet weak var phoneNumTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var detailAddressTextField: UITextField!
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        dataManager.academyProfile(academyIdx: KeyCenter.userIndex, delegate: self)
        setButtonLayout()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    
}

//MARK:- API

extension AcademyMyProfileViewController {
    
    func academyProfile(result : academyProfileResponse){
        if result.isSuccess{
            
            emailTextField.text = result.result.academyEmail
            academyNameTextField.text = result.result.academyName
            phoneNumTextField.text = result.result.academyPhone
            addressTextField.text = result.result.academyAddress
            detailAddressTextField.text = result.result.academyDetailAddress
            
           
            //장르 string 잘라서 배열로
            let filterdGenreList = String(result.result.academyGernre.filter { !" ".contains($0) }).components(separatedBy: ",")
            
            
            for i in filterdGenreList{
                
                let genreIdx = genreList.firstIndex(of: "\(i)")


                buttonList[genreIdx ?? 0]?.layer.borderColor = #colorLiteral(red: 0.9450980392, green: 0.0862745098, blue: 0.6862745098, alpha: 1)
                buttonList[genreIdx ?? 0]?.setTitleColor(#colorLiteral(red: 0.9450980392, green: 0.0862745098, blue: 0.6862745098, alpha: 1), for: .normal)
                
            }
            
            
           
            
//            kpopButton
//            coreoButton
//            hiphopButton
//            girlsHiphopButton
//            waakingButton
//            popinButton
//            rockingButton
//            crumpButton
//            voguingButton
//            houseButton
            
        }else{
            
            presentAlert(title:  result.message)
            
        }
    
        
    }
    
    
    
    
    func failedToRequest(){
        
        self.presentAlert(title: "서버와의 연결이 원활하지 않습니다")

    }

}
