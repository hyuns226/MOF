//
//  dayPicker.swift
//  MOF
//
//  Created by 이현서 on 2022/01/26.
//

import Foundation
import UIKit

class dayPicker : UIPickerView{
    
    let day = ["월요일", "화요일", "수요일", "목요일", "금요일", "토요일", "일요일"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1

    }


    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return day.count

    }


    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return day[row]

    }


    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        print(day[row])
    }

    
}
    
    

