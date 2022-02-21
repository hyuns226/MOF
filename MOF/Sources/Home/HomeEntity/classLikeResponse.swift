//
//  classLikeResponse.swift
//  MOF
//
//  Created by 이현서 on 2022/02/21.
//

import Foundation
struct classLikeResponse : Decodable{
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : classLikeResults?
}

struct classLikeResults : Decodable{
    var APIResult : String
    var userClassLikeIdx : Int
    
}
