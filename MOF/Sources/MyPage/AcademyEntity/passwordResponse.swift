//
//  passwordResponse.swift
//  MOF
//
//  Created by 이현서 on 2022/02/10.
//

import Foundation
struct passwordResponse : Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result : passwordResult?
    
    
    
}

struct passwordResult : Decodable {
    var APIResult : String
    var academyIdx : String
    
    enum CodingKeys : String, CodingKey{

            case APIResult = "API Result"
            case academyIdx
        }
    
}
