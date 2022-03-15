//
//  addClassRequest.swift
//  MOF
//
//  Created by 이현서 on 2022/01/26.
//

import Foundation

struct addClassRequest : Encodable{
    
    
    var className : String
    var classType : String
    var classPrice : Int
    var classGernre : String
    var classPersonnel : Int
    var classIntro : String
    var classTeacherName : String
    var classTeacherIntro : String
    var classStartTime1 : String
    var classEndTime1 : String
    var classStartTime2 : String
    var classEndTime2 : String
    
  
}
