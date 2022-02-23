//
//  detailRegularClass.swift
//  MOF
//
//  Created by 이현서 on 2022/02/21.
//

import Foundation
struct detailRegularClassResponse : Decodable{
    
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : [detailRegularClassResults?]
}

struct detailRegularClassResults : Decodable{
    var classIdx : Int
    var classImageUrl : String?
    var className : String
    var classPrice : Int
    var classPersonnel : String?
    var classType : String
    var classStartTime1 : String
    var classEndTime1 : String
    var classStartTime2 : String?
    var classEndTime2 : String?
    var classIntro : String
    var teacherImgUrl : String?
    var classTeacherName : String?
    var classTeacherIntro : String?
    var classGernre : String
}
