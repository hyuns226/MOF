//
//  classEnrollResponse.swift
//  MOF
//
//  Created by 이현서 on 2022/02/23.
//

import Foundation
struct classEnrollResponse : Decodable{
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : enrollResults?
}

struct enrollResults : Decodable{
    var APIResult : String
    var enrollIdx : Int
}
