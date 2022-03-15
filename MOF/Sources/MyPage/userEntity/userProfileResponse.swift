//
//  userProfileResponse.swift
//  MOF
//
//  Created by 이현서 on 2022/01/13.
//

struct userProfileResponse : Decodable{
    
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : profileResults?
}

struct profileResults : Decodable {
        var userName : String
        var userEmail : String
        var userProfileImgUrl : String?
        var userAge : String
        var userGender : String
        var userPhone : String
    }
