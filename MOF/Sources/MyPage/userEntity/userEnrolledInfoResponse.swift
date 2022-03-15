//
//  userEnrolledInfoResponse.swift
//  MOF
//
//  Created by 이현서 on 2022/03/05.
//

import Foundation
struct userEnrolledInfoResponse : Decodable{
    var isSuccess : Bool
    var code : Int
    var message  : String
    var result : [userEnrolledInfoResults]?
    
}

struct userEnrolledInfoResults : Decodable{
    var className : String
    var userName : String
    var userPhone : String
    var userAge : String
    var userGender : String
    var classStatus : String
    var enrollTime : String
    var enrollSubmit : String
    var classImageUrl : String?
    var classPrice : Int?
}
