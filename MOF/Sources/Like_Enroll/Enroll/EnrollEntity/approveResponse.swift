//
//  approveResponse.swift
//  MOF
//
//  Created by 이현서 on 2022/03/14.
//

import Foundation
struct approveResponse : Decodable{
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : approveResponseResults?
}

struct approveResponseResults : Decodable{
    var APIResult : String
    var enrollIdx : String
    
}
