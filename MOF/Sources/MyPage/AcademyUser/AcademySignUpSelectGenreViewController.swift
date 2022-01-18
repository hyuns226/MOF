//
//  AcademySignUpSelectGenreViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/01/18.
//

import UIKit
class AcademySignUpSelectGenreViewController : UIViewController{
    
    @IBOutlet weak var AcademyImageView: UIImageView!
    @IBOutlet weak var cameraButton: UIButton!
    
    @IBOutlet weak var kpopButton: UIButton!
    @IBOutlet weak var coreoButton: UIButton!
    @IBOutlet weak var hiphopButton: UIButton!
    @IBOutlet weak var rockingButton: UIButton!
    @IBOutlet weak var crumpButton: UIButton!
    @IBOutlet weak var voguingButton: UIButton!
    @IBOutlet weak var houseButton: UIButton!
    
    @IBOutlet weak var nextButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButtonLayout()
    }
    
    //MARK:- FUNCTION
    func setButtonLayout(){
        kpopButton.layer.cornerRadius = 14
        coreoButton.layer.cornerRadius = 14
        hiphopButton.layer.cornerRadius = 14
        rockingButton.layer.cornerRadius = 14
        crumpButton.layer.cornerRadius = 14
        voguingButton.layer.cornerRadius = 14
        houseButton.layer.cornerRadius = 14
        
        nextButton.layer.cornerRadius = 17.5
        
    }
    
}
