//
//  specificaAcademyLikesResponse.swift
//  MOF
//
//  Created by 이현서 on 2022/02/21.
//

import Foundation
struct specificaAcademyLikesResponse : Decodable{
    var isSuccess :Bool
    var code : Int
    var message : String
    var result : [specificAcademyLikesResults]?
}

struct specificAcademyLikesResults : Decodable{
    var userAcademyLikeIdx : Int
    var academyIdx : Int
    var academyName : String
    var academyBackImgUrl : String?
    var academyGernre : String
}
