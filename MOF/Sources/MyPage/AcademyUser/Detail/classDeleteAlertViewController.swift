//
//  classDeleteAlertViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/03/01.
//

import Foundation
import UIKit
class classDeleteAlertViewController : UIViewController{

    var classIdx = -1
    var dataManager = AcademyMyPageDataManager()
    
    @IBOutlet weak var deleteButtonAction: UIButton!
    
    @IBAction func deleteButtonAction(_ sender: Any) {
        dataManager.deleteClass(academyIdx: KeyCenter.userIndex, classIdx: self.classIdx, delegate: self)
    }
    
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
}

//MARK: API
extension classDeleteAlertViewController{
    func deleteClass(result : deleteClassResponse){
        if result.isSuccess{
            
            print("성공")
            AcademyMyPageViewController.deleteAlertFlag = 1
            
            self.view.window!.rootViewController?.dismiss(animated: false, completion: nil)
            
        }else{
            presentAlert(title: result.message)
        }
    }
    
    func failedToRequest(){
        
        self.presentAlert(title: "서버와의 연결이 원활하지 않습니다")
    
    }
}
