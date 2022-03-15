//
//  deleteClassResponse.swift
//  MOF
//
//  Created by 이현서 on 2022/03/01.
//

import Foundation
struct deleteClassResponse : Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result : deleteClassResult?
    
    
    
}

struct deleteClassResult : Decodable {
    var APIResult : String
    var classIdx : String
    
    enum CodingKeys : String, CodingKey{

            case APIResult = "API Result"
            case classIdx
        }
    
}
