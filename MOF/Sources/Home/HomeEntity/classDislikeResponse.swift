//
//  classDislikeResponse.swift
//  MOF
//
//  Created by 이현서 on 2022/02/21.
//

import Foundation
struct classDislikeResponse : Decodable{
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : ClassDislikeResults?
}

struct ClassDislikeResults : Decodable{
    var APIResult : String
    var 삭제된유저수업좋아요Idx : Int
    
}
