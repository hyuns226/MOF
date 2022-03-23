//
//  passwordResponse.swift
//  MOF
//
//  Created by 이현서 on 2022/03/23.
//

import Foundation
struct userPasswordResponse : Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result : userPasswordResult?
    
    
    
}

struct userPasswordResult : Decodable {
    var APIResult : String
    var userIdx : String
    
    enum CodingKeys : String, CodingKey{

            case APIResult = "API Result"
            case userIdx
        }
    
}
