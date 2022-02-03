//
//  userOnedayClassResponse.swift
//  MOF
//
//  Created by 이현서 on 2022/02/03.
//

struct userOnedayClassResponse : Decodable{
    
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : [onedayResults?]?
    
}

struct onedayResults : Decodable{
    
    var enrollIdx : Int
    var enrollClassIdx : Int
    var className : String
    var classType : String
    var classTeacherName : String
}
