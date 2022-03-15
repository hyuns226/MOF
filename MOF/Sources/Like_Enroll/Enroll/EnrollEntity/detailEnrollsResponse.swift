//
//  detailEnrollsResponse.swift
//  MOF
//
//  Created by 이현서 on 2022/03/13.
//

import Foundation
struct detailEnrollsResponse : Decodable{
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : [detailEnrollResults]?
    
}

struct detailEnrollResults : Decodable{
    var userName : String
    var userPhone : String
    var userAge : String
    var userGender : String
    var createdAt : String
    var enrollSubmit : String
    var enrollIdx : Int
    var enrollUserIdx : Int
}

