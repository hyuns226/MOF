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
    @IBOutlet weak var startTimePickerView: UIPickerView!
   
    @IBOutlet weak var endTimePickerView: UIPickerView!
    
    
    let day = ["월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"]
    
    let Hour = ["00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23"]
    
    let Time = ["00", "10","20","30","40","50"]
    
    override func viewDidLoad() {
        dayPIckerView.delegate = self
        startTimePickerView.delegate = self
        endTimePickerView.delegate = self
       
        
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
        
        if pickerView == dayPIckerView{
            return 1
        }else if pickerView == startTimePickerView{
            return 2
        }else if pickerView == endTimePickerView{
            return 2
        }
        return 0;
    }


    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if pickerView == dayPIckerView{
            return day.count
            
        }else if pickerView == startTimePickerView{
            switch component{
            case 0:
                return Hour.count
            case 1:
                return Time.count
            default:
                print("")
            }
            
        }else if pickerView == endTimePickerView{
            switch component{
            case 0:
                return Hour.count
            case 1:
                return Time.count
            default:
                print("")
            }
            
        }
        return 0;
        
       
    }


    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        if pickerView == dayPIckerView{
            let pickerLabel = UILabel()
            pickerLabel.font = UIFont(name: "NotoSansCJKkr-Regular", size: CGFloat(14))
            pickerLabel.text = day[row]
            pickerLabel.textAlignment = .center
            return pickerLabel
            
        }else if pickerView == startTimePickerView{
            switch component{
            case 0:
                let pickerLabel = UILabel()
                pickerLabel.font = UIFont(name: "NotoSansCJKkr-Regular", size: CGFloat(14))
                pickerLabel.text = Hour[row]
                pickerLabel.textAlignment = .center
                return pickerLabel
            case 1:
                let pickerLabel = UILabel()
                pickerLabel.font = UIFont(name: "NotoSansCJKkr-Regular", size: CGFloat(14))
                pickerLabel.text = Time[row]
                pickerLabel.textAlignment = .center
                return pickerLabel
            default:
                print("")
            }
            
        }else if pickerView == endTimePickerView{
            switch component{
            case 0:
                let pickerLabel = UILabel()
                pickerLabel.font = UIFont(name: "NotoSansCJKkr-Regular", size: CGFloat(14))
                pickerLabel.text = Hour[row]
                pickerLabel.textAlignment = .center
                return pickerLabel
            case 1:
                let pickerLabel = UILabel()
                pickerLabel.font = UIFont(name: "NotoSansCJKkr-Regular", size: CGFloat(14))
                pickerLabel.text = Time[row]
                pickerLabel.textAlignment = .center
                return pickerLabel
            default:
                print("")
            }
            
        }
        
        return UIView();
            
        }
    

    

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        if pickerView == dayPIckerView{
            dayText = day[row]
           
            dayTextForSend = Constant.DateforDays[row]
            print(Constant.DateforDays[row])

        }else if pickerView == startTimePickerView{
            switch component{
            case 0:
                startHourText = Hour[row]
                print(Hour[row])
            case 1:
                startMinuteText = Time[row]
                print(Time[row])
            default:
                print("")
            }

        }else if pickerView == endTimePickerView{
            switch component{
            case 0:
                endHourText = Hour[row]
                print(Hour[row])
            case 1:
                endMinuteText = Time[row]
                print(Time[row])
            default:
                print("")
            }
        }

    
    }
}
