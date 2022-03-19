//
//  specificAcademyProtocol.swift
//  MOF
//
//  Created by 이현서 on 2022/02/24.
//

import Foundation
import UIKit

//장르별,위치별, 검색어 별로 조회할때 필요
protocol specificAcademyProtocol {
    func specificAcademy(result : specificGenreResponse)
}


//like탭 : 지역필터 -> likeVC로 지역 전달
protocol likeFilterDelegate: class {
    func sendregion(region : String)
}

//정규 - 첫번째 라벨
protocol selectedDateProtocol{
    func sendDate(startDateForShow : String, startDateForSend : String,  endDateForShow : String, endDateForSend : String)
}

//정규 - 두번째 라벨
protocol selectedDateProtocol2{
    func sendDate2(startDateForShow : String, startDateForSend : String,  endDateForShow : String, endDateForSend : String)
}

//원데이
protocol selectedOnedayDateProtocol{
    func sendonedayDate(startDateForShow : String, startDateForSend : String,  endDateForShow : String, endDateForSend : String)
}

protocol teacherInfoProtocol{
    func sendTeacherInfo(teacherImage : UIImage, teacherName:String, teacherIntro : String)
}

protocol addClassAlertProtocol{
    func showAlert()
}


