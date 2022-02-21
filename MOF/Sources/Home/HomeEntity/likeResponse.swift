//
//  likeResponse.swift
//  MOF
//
//  Created by 이현서 on 2022/02/14.
//

import Foundation
struct likeResponse : Decodable{
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : likeResults?
}

struct likeResults : Decodable{
    var APIResult : String
    var userAcademyLikeIdx : Int
    
}
