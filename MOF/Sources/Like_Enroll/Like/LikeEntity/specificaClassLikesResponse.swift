//
//  specificaClassLikesResponse.swift
//  MOF
//
//  Created by 이현서 on 2022/02/21.
//

import Foundation
struct specificaClassLikesResponse : Decodable{
    var isSuccess :Bool
    var code : Int
    var message : String
    var result : [specificClassLikesResults?]
}

struct specificClassLikesResults : Decodable{
    var userClassLikeIdx : Int
    var classIdx : Int
    var className : String
    var classImageUrl : String?
    var classTeacherName : String
}
