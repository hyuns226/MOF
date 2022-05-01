//
//  allClassLikesResponse.swift
//  MOF
//
//  Created by 이현서 on 2022/02/21.
//

import Foundation
struct allClassLikesResponse : Decodable{
    var isSuccess :Bool
    var code : Int
    var message : String
    var result : [allClassLikesResults?]
    
}

struct allClassLikesResults : Decodable{
    var userClassLikeIdx : Int
    var classLikeClassIdx : Int
    var className : String
    var classImageUrl : String?
    var classTeacherName : String
    var userName : String
    var classType : String
}
