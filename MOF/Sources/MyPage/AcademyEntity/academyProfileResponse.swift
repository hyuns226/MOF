//
//  academyProfileResponse.swift
//  MOF
//
//  Created by 이현서 on 2022/02/09.
//

import Foundation
struct academyProfileResponse : Decodable{
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : academyProfileResult
    
}

struct academyProfileResult : Decodable{
    
    var academyName : String
    var academyEmail : String
    var academyBackImgUrl : String?
    var academyAddress : String
    var academyDetailAddress : String
    var academyGernre : String
    var academyPhone : String
}
