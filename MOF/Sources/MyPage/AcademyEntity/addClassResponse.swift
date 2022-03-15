//
//  addClassResponse.swift
//  MOF
//
//  Created by 이현서 on 2022/02/27.
//

import Foundation
struct addClassResponse : Decodable{
    var isSuccess : Bool
    var code : Int
    var message : String
    var result : addClassResults
}

struct addClassResults : Decodable{
    var APIResult : String
    var classIdx : Int
    
    enum CodingKeys : String, CodingKey{

            case APIResult = "API Result"
            case classIdx
        }
    
}
