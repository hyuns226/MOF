//
//  dislikeResponse.swift
//  MOF
//
//  Created by 이현서 on 2022/02/14.
//

import Foundation
struct dislikeResponse : Decodable{
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : dislikeResults?
}

struct dislikeResults : Decodable{
    var APIResult : String
    var 삭제된유저학원좋아요Idx : Int
    
}
