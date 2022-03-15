//
//  datePickerPopUpViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/01/26.
//

import Foundation
import UIKit

class datePickerPopUpViewController : UIViewController{
    
    var dateLabel = ""
    
    var delegate : selectedDateProtocol?
    var delegate2 : selectedDateProtocol2?
    
    let addClassVC = AddClassViewController()
    
    var dayText = "월요일"
    var dayTextForSend = Constant.DateforDays[0]
    var startHourText = "00"
    var startMinuteText = "00"
    var endHourText = "00"
    var endMinuteText = "00"
    
    
    
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var dayPIckerView: UIPickerView!
    
    @IBOutlet weak var startHourPickerView: UIPickerView!
    @IBOutlet weak var startMinutePickerView: UIPickerView!
    
    @IBOutlet weak var endHourPickerView: UIPickerView!
    @IBOutlet weak var endMinutePickerView: UIPickerView!
    
    
    let day = ["월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"]
    
    let Hour = ["00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23"]
    
    let Time = ["00", "10","20","30","40","50"]
    
    override func viewDidLoad() {
        dayPIckerView.delegate = self
        startHourPickerView.delegate = self
        startMinutePickerView.delegate = self
        endHourPickerView.delegate = self
        endMinutePickerView.delegate = self
        
    }
    
    //MARK:- FUNCTION
    @IBAction func addTimeButtonAction(_ sender: Any) {
        
        if dateLabel == "one"{
            self.delegate?.sendDate(startDateForShow: dayText + " \(startHourText):\(startMinuteText)" , startDateForSend: dayTextForSend+startHourText+startMinuteText+"00", endDateForShow: "\(endHourText):\(endMinuteText)" , endDateForSend:dayTextForSend+endHourText+endMinuteText+"00")
            self.dismiss(animated: false, completion: nil)
        }else{
            self.delegate2?.sendDate2(startDateForShow: dayText + " \(startHourText):\(startMinuteText)" , startDateForSend: dayTextForSend+startHourText+startMinuteText+"00", endDateForShow: "\(endHourText):\(endMinuteText)" , endDateForSend:dayTextForSend+endHourText+endMinuteText+"00")
            self.dismiss(animated: false, completion: nil)
        }
    
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
            componet = Hour[row]
            break
        case startMinutePickerView :
            componet = Time[row]
            break
        case endHourPickerView :
            componet =  Hour[row]
            break
        case endMinutePickerView :
            componet = Time[row]
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
            dayTextForSend = Constant.DateforDays[row]
            print(Constant.DateforDays[row])
            break
        case startHourPickerView :
            startHourText = Hour[row]
            print(Hour[row])
            break
        case startMinutePickerView :
            startMinuteText = Time[row]
            print(Time[row])
        case endHourPickerView :
            endHourText = Hour[row]
            print(Hour[row])
            break
        case endMinutePickerView :
            endMinuteText = Time[row]
            print(Time[row])
            break
        default:
            print("")
        }
        
    }
    
    
    
    
    
    
    
    
}
