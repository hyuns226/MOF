//
//  userModifyRequest.swift
//  MOF
//
//  Created by 이현서 on 2022/01/13.
//

struct userModifyRequest : Encodable{
    
    var userEmail : String?
    var userName : String?
    var userPhone : String?
    var userAge : String?
    var userGender : String?
    var userAddress : String?
    var userProfileImgUrl : String?
}
