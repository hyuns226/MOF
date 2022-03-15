//
//  modifyClassResponse.swift
//  MOF
//
//  Created by 이현서 on 2022/03/01.
//

import Foundation

struct modifyClassResponse : Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result : modifyClassResults?
    
    
    
}

struct modifyClassResults : Decodable {
    var APIResult : String
    var classIdx : String
    
    enum CodingKeys : String, CodingKey{

            case APIResult = "API Result"
            case classIdx
        }
    
}
