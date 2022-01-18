//
//  SignUpViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/01/08.
//

import UIKit

protocol regionDelegate: class {
    func sendregionName(forShow : String)
}

class SignUpViewController : UIViewController{
    
    lazy var dataManager = UserMyPageDataManager()
    
    var usersInput : usersRequest = usersRequest(image: nil, userEmail: "", userPWD: "", userName: "", userPhone: "", userAge: "", userGender: "", userAddress: "")
    
    
    var gender : String = "Male"
    var isTextFieldReady = false
    var isButtonReady = false
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passWordTextField: UITextField!
    @IBOutlet weak var checkPassWordTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var phoneNumTextFiled: UITextField!
    @IBOutlet weak var AgeTextField: UITextField!
    @IBOutlet weak var MaleButton: UIButton!
    @IBOutlet weak var FemaleButton: UIButton!
    @IBOutlet weak var addressButton: UIButton!
    @IBOutlet weak var SignUpButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(checkTextField), name: UITextField.textDidChangeNotification, object: nil)
        
        SignUpButton.isEnabled = false
        SignUpButton.layer.cornerRadius = 17.5
        
        MaleButton.layer.cornerRadius = 15
        FemaleButton.layer.cornerRadius = 15
        MaleButton.isSelected = true
        FemaleButton.isSelected = false
        
        
        //let jpgdata = #imageLiteral(resourceName: "7690").pngData()
        
        //print(jpgdata)

        
        
        
    }
    
    
    @IBAction func maleButtonAction(_ sender: Any) {
        
        
        if FemaleButton.isSelected == true{
            FemaleButton.isSelected = false
            FemaleButton.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1)
            FemaleButton.setTitleColor(#colorLiteral(red: 0.7175753713, green: 0.7176977396, blue: 0.7261662483, alpha: 1), for: .normal)
            MaleButton.isSelected = true
            MaleButton.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.0862745098, blue: 0.6862745098, alpha: 1)
            MaleButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            gender = "Male"
            print(gender)
        
        }
        
    }
    
    @IBAction func femaleButtonAction(_ sender: Any) {
       
        if MaleButton.isSelected == true{
            MaleButton.isSelected = false
            MaleButton.backgroundColor = #colorLiteral(red: 0.9294117647, green: 0.9294117647, blue: 0.9294117647, alpha: 1)
            MaleButton.setTitleColor(#colorLiteral(red: 0.7175753713, green: 0.7176977396, blue: 0.7261662483, alpha: 1), for: .normal)
            
            FemaleButton.isSelected = true
            FemaleButton.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.0862745098, blue: 0.6862745098, alpha: 1)
            FemaleButton.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: .normal)
            gender = "Female"
            print(gender)
        }
        
    }
    

    @IBAction func SelectAddressButtonAction(_ sender: Any) {
        
        let regionVC = self.storyboard?.instantiateViewController(withIdentifier: "GeneralSelectRegionViewController") as! GeneralSelectRegionViewController
        regionVC.delegate = self
        self.navigationController?.pushViewController(regionVC, animated: true)
        
        

        
        
    }
    
    
    //MARK: - 텍스트 필드 채워지면 버튼 활성화
    @objc func checkTextField(){
        let filteredArray = [emailTextField,passWordTextField,checkPassWordTextField,nameTextField,phoneNumTextFiled,AgeTextField].filter { $0?.text == "" }
        if (filteredArray.isEmpty){
            isTextFieldReady = true
            if isButtonReady == true{
                SignUpButton.isEnabled = true
                SignUpButton.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.0862745098, blue: 0.6862745098, alpha: 1)
                
            }else{
                SignUpButton.isEnabled = false
                SignUpButton.backgroundColor = #colorLiteral(red: 0.808078289, green: 0.8075512052, blue: 0.829269588, alpha: 1)
            
            }
            
            
        } else {
            isTextFieldReady = false
            SignUpButton.isEnabled = false
            SignUpButton.backgroundColor = #colorLiteral(red: 0.808078289, green: 0.8075512052, blue: 0.829269588, alpha: 1)
            
        }
    }
    
    func checkButton(){
        if (isButtonReady && isTextFieldReady){
            SignUpButton.isEnabled = true
            SignUpButton.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.0862745098, blue: 0.6862745098, alpha: 1)
        }
        
        print(isButtonReady)
        print(isTextFieldReady)
        
        
    }
    
    
    func setUserInput(){
        usersInput.image = nil
        usersInput.userEmail = emailTextField.text ?? ""
        usersInput.userPWD = passWordTextField.text ?? ""
        usersInput.userName = nameTextField.text ?? ""
        usersInput.userPhone = phoneNumTextFiled.text ?? ""
        usersInput.userAge = AgeTextField.text ?? ""
        usersInput.userGender = gender
        usersInput.userAddress = addressButton.titleLabel?.text ?? ""
        
    }
    
    
    
    
    @IBAction func SignUpButtonAction(_ sender: Any) {
        setUserInput()
        print(usersInput)
        
      //  dataManager.users(usersInput, delegate: self)
        let welcomeVC = self.storyboard?.instantiateViewController(identifier: "WelcomViewController") as! WelcomViewController

        self.navigationController?.pushViewController(welcomeVC, animated: true)

        welcomeVC.welcomeText = usersInput.userName + "님, 안녕하세요!"
    }
    
    
    

    
}


//MARK: - delegate
extension SignUpViewController : regionDelegate{
    func sendregionName(forShow: String) {
        addressButton.setTitle(forShow, for: .normal)
        addressButton.setTitleColor(#colorLiteral(red: 0.09803921569, green: 0.09803921569, blue: 0.09803921569, alpha: 1), for: .normal)
        isButtonReady = true
        checkButton()
        
        
    }
    

    

}

//MARK: - API
extension SignUpViewController{
    
    
    func users(result : usersResponse){
        if result.isSuccess == true{
            print(result)
            let welcomeVC = self.storyboard?.instantiateViewController(identifier: "WelcomViewController") as! WelcomViewController
            welcomeVC.welcomeText = usersInput.userName + "님, 안녕하세요!"
            welcomeVC.userIndex = result.result!.userIdx
            print("userindex : \(result.result!.userIdx)")
            self.navigationController?.pushViewController(welcomeVC, animated: true)
            
        }else{
            self.presentAlert(title: result.message)
            
        }
    
    }
    
    func failedToRequest(message : String){
        
        self.presentAlert(title: message)
    
    }
    
    
}

