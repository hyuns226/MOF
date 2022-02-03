//
//  academySignUpResponse.swift
//  MOF
//
//  Created by 이현서 on 2022/02/03.
//

struct academySignUpResponse : Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result : academyResult?
    
    
    
}

struct academyResult : Decodable {
    var APIResult : String
    var academyIdx : Int
    
    enum CodingKeys : String, CodingKey{

            case APIResult = "API Result"
            case academyIdx
        }
    
}

