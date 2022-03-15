//
//  datePickerForOnedayViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/02/25.
//

import Foundation
import UIKit
class datePickerForOnedayPopupViewController : UIViewController{
    
    var delegate : selectedOnedayDateProtocol?
    
    var nowYear = ""
    var nowMonth = ""
    var nowDate = [String()]
    
    var dateText = ""
    var dateTextForSend = ""
    var startHourText = "00"
    var startMinuteText = "00"
    var endHourText = "00"
    var endMinuteText = "00"
    
    let Hour = ["00","01","02","03","04","05","06","07","08","09","10","11","12","13","14","15","16","17","18","19","20","21","22","23"]
    
    let Time = ["00", "10","20","30","40","50"]
    
    
    
    @IBOutlet weak var datePickerView: UIPickerView!
    @IBOutlet weak var startTimePickerView: UIPickerView!
    @IBOutlet weak var endTimePickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calculateThisMonthDays()
        
        datePickerView.delegate = self
        startTimePickerView.delegate = self
        endTimePickerView.delegate = self
    }
    
    func calculateThisMonthDays(){
        let date = Date(timeIntervalSinceNow: 0)
        var calendar = Calendar(identifier: .gregorian)
        
        calendar.locale = Locale(identifier: "ko")

        let components = calendar.dateComponents([.year, .month], from: date)

        
        let startOfMonth = calendar.date(from: components)!
        //현재 달의 첫번쨰 날짜
        let comp1 = calendar.dateComponents([.year, .month,.day,.weekday,.weekOfMonth], from: startOfMonth)

        
        let nextMonth = calendar.date(byAdding: .month, value: +1, to: startOfMonth)
        let endOfMonth = calendar.date(byAdding: .day, value: -1, to:nextMonth!)
         
        //이번 달의 마지막 날짜
        let comp2 = calendar.dateComponents([.day,.weekday,.weekOfMonth], from: endOfMonth!)
        let weekArr = calendar.shortWeekdaySymbols

        if let weekday = comp1.weekday, let weekday2 = comp2.weekday {
            print(weekArr[weekday-1])
            print(weekArr[weekday2-1])
        }

        nowMonth = String(comp1.month ?? 0)
        nowYear = String(comp1.year ?? 0)
        
        //초기값 지정
        dateText = "\(nowMonth)월 1일"
        dateTextForSend = String(format: "%d%02d01",Int(nowYear)!,Int(nowMonth)!)
        
        for i in comp1.day!...comp2.day! {
            let date = String(i)
            nowDate.append("\(nowMonth)월 \(date)일")
            

                                
                               
        }
        
        nowDate.removeFirst()
        
        print("nowyear : \(nowYear)")
        print("nowmonth : \(nowMonth)")
        print("nowdate : \(nowDate)")
        print("dateforsend : \(dateTextForSend)")
    }
    
    
    @IBAction func closeButtonAction(_ sender: Any) {
        
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func addTimeButton(_ sender: Any) {
      self.delegate?.sendonedayDate(startDateForShow: "\(dateText) \(startHourText):\(startMinuteText)", startDateForSend: dateTextForSend+startHourText+startMinuteText, endDateForShow: "\(endHourText):\(endMinuteText)", endDateForSend: dateTextForSend+endHourText+endMinuteText)
        
        self.dismiss(animated: false, completion: nil)
    }
    
    
}

//MARK:- EXTENSION
extension datePickerForOnedayPopupViewController : UIPickerViewDelegate, UIPickerViewDataSource{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        if pickerView == datePickerView{
            return 1
        }else if pickerView == startTimePickerView{
            return 2
        }else if pickerView == endTimePickerView{
            return 2
        }
        return 0;
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        
        if pickerView == datePickerView{
            return nowDate.count
            
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
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String{

        
        if pickerView == datePickerView{
            return nowDate[row]
            
        }else if pickerView == startTimePickerView{
            switch component{
            case 0:
                return Hour[row]
            case 1:
                return Time[row]
            default:
                print("")
            }
            
        }else if pickerView == endTimePickerView{
            switch component{
            case 0:
                return Hour[row]
            case 1:
                return Time[row]
            default:
                print("")
            }
            
        }
        
        return "";
    
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        
        if pickerView == datePickerView{
            dateText = nowDate[row]
            
            dateTextForSend = String(format: "%d%02d%02d",Int(nowYear)!,Int(nowMonth)!,row+1)

            print(dateText,dateTextForSend)

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
