//
//  loginResponse.swift
//  MOF
//
//  Created by 이현서 on 2022/01/13.
//

struct loginResponse : Decodable{
    
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : results?
}

struct results : Decodable{
    var APIResult : String
    var 유저타입 : String
    var userIdx : Int
    var jwt : String
    
}



