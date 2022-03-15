//
//  userRegularClassResponse.swift
//  MOF
//
//  Created by 이현서 on 2022/02/03.
//

struct userRegularClassResponse : Decodable{
    
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : [regularResults]?
    
}

struct regularResults : Decodable{
    
    
    var className : String
    var classTeacherName : String
    var classStartTime1 : String
    var classEndTime1 : String
    var classStartTime2 : String?
    var classEndTime2 : String?
    var enrollSubmit : String
    var enrollIdx : Int
    var classIdx : Int
}
