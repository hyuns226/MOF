//
//  specificGenreResponse.swift
//  MOF
//
//  Created by 이현서 on 2022/02/13.
//

import Foundation
struct specificGenreResponse : Decodable{
    
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : [specificResults]?
}

struct specificResults: Decodable{
    var academyIdx : Int
    var academyName : String
    var academyBackImgUrl : String?
    var academyDetailAddress : String
    var academyPhone : String
}
