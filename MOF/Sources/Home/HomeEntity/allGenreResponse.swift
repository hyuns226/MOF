//
//  allGenreResponse.swift
//  MOF
//
//  Created by 이현서 on 2022/02/12.
//

import Foundation
struct allGenreResponse : Decodable{
    
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : [allResults]?
}

struct allResults: Decodable{
    var academyIdx : Int
    var academyName : String
    var academyBackImgUrl : String?
    var academyAddress : String
    var academyDetailAddress : String
    var academyPhone : String
}
