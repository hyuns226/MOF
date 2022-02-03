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
    var result : [regularResults?]?
    
}

struct regularResults : Decodable{
    
    var enrollIdx : Int
    var enrollClassIdx : Int
    var className : String
    var classType : String
    var classTeacherName : String
}
