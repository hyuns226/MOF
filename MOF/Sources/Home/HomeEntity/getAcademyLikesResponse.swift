//
//  getAcademyLikesResponse.swift
//  MOF
//
//  Created by 이현서 on 2022/02/20.
//

struct getAcademyLikesResponse : Decodable{
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : academyLikesResults
}

struct academyLikesResults : Decodable{
    var APIResult : String
    var 좋아요여부 : Bool
}
