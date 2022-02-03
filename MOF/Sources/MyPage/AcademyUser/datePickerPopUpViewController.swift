//
//  datePickerPopUpViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/01/26.
//

import Foundation
import UIKit

class datePickerPopUpViewController : UIViewController{
    
    let addClassVC = AddClassViewController()
    
    var dayText = ""
    var startHourText = ""
    var startMinuteText = ""
    var endHourText = ""
    var endMinuteText = ""
    
    
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var dayPIckerView: UIPickerView!
    
    @IBOutlet weak var startHourPickerView: UIPickerView!
    @IBOutlet weak var startMinutePickerView: UIPickerView!
    
    @IBOutlet weak var endHourPickerView: UIPickerView!
    @IBOutlet weak var endMinutePickerView: UIPickerView!
    
    
    let day = ["월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"]
    
    let Hour = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24]
    
    let Time = [10,20,30,40,50,60]
    
    override func viewDidLoad() {
        dayPIckerView.delegate = self
        startHourPickerView.delegate = self
        startMinutePickerView.delegate = self
        endHourPickerView.delegate = self
        endMinutePickerView.delegate = self
        
    }
    
    //MARK:- FUNCTION
    @IBAction func addTimeButtonAction(_ sender: Any) {
        
        addClassVC.startTime = dayText+startHourText+startMinuteText
        addClassVC.endTime = endHourText+endMinuteText
        
        print(addClassVC.startTime,addClassVC.endTime)
        
        self.dismiss(animated: false, completion: nil)
        
    }
    
    
    @IBAction func closeButton(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    
}

//MARK:- EXTENSION
extension datePickerPopUpViewController : UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }


    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        var componentNum = 0
        
        switch pickerView{
        case dayPIckerView :
            componentNum =  day.count
            break
        case startHourPickerView :
            componentNum = Hour.count
            break
        case startMinutePickerView :
            componentNum = Time.count
            break
        case endHourPickerView :
            componentNum = Hour.count
            break
        case endMinutePickerView :
            componentNum = Time.count
            break
        default:
            print("")
        }
    
        
        
        return componentNum
        
       
    }


    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        var componet = ""
        
        switch pickerView{
        case dayPIckerView :
            componet = day[row]
            break
        case startHourPickerView :
            componet = String(Hour[row])
            break
        case startMinutePickerView :
            componet = String(Time[row])
            break
        case endHourPickerView :
            componet =  String(Hour[row])
            break
        case endMinutePickerView :
            componet = String(Time[row])
            break
        default:
            print("")
        }
    
        return componet

    }


    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch pickerView{
        case dayPIckerView :
            dayText = day[row]
            print(day[row])
            break
        case startHourPickerView :
            startHourText = String(Hour[row])
            print(Hour[row])
            break
        case startMinutePickerView :
            startMinuteText = String(Time[row])
            print(Time[row])
        case endHourPickerView :
            endHourText = String(Hour[row])
            print(Hour[row])
            break
        case endMinutePickerView :
            endMinuteText = String(Time[row])
            print(Time[row])
            break
        default:
            print("")
        }
        
    }
    
    
    
    
    
    
    
    
}
