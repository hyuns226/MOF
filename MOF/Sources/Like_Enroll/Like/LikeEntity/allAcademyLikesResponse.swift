//
//  allAcademyLikes.swift
//  MOF
//
//  Created by 이현서 on 2022/02/20.
//

import Foundation
struct allAcademyLikesResponse : Decodable{
    var isSuccess :Bool
    var code : Int
    var message : String
    var result : [allAcademyLikesResults]?
    
}

struct allAcademyLikesResults : Decodable{
    var userAcademyLikeIdx : Int
    var academyLikeAcademyIdx : Int
    var academyName : String
    var academyBackImgUrl : String?
    var academyGernre : String
    var userName : String
}
