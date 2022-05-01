//
//  AcademyWelcomViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/01/18.
//

import UIKit
class AcademyWelcomViewController : UIViewController{
    
    @IBOutlet weak var academyImageView: UIImageView!
    @IBOutlet weak var gotoLoginButton: UIButton!
    @IBOutlet weak var welcomLabel: UILabel!
    
    var welcomeText = ""
    var welcomImage = UIImage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        academyImageView.image = welcomImage
        welcomLabel.text = welcomeText
        gotoLoginButton.layer.cornerRadius = 17.5
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    //MARK:-FUNCTION
    @IBAction func goToLoginAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
