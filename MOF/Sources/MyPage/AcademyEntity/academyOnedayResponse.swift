//
//  academyOnedayResponse.swift
//  MOF
//
//  Created by 이현서 on 2022/02/13.
//

import Foundation
struct academyOnedayResponse : Decodable{
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : [academyOnedayResult]
    
    
    
}

struct academyOnedayResult : Decodable{
    var classIdx : Int
    var className : String
    var classPrice : Int?
    var classGernre : String
    var classPersonnel : Int?
    var classIntro : String
    var classTeacherName : String
    var classStartTime1 : String
    var classEndTime1 : String
}
