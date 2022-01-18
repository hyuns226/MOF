//
//  usersResponse.swift
//  MOF
//
//  Created by 이현서 on 2022/01/08.
//

struct usersResponse : Decodable {
    var isSuccess: Bool
    var code: Int
    var message: String
    var result : userResult?
    
    
    
}

struct userResult : Decodable {
    var APIResult : String
    var userIdx : Int
    
    enum CodingKeys : String, CodingKey{

            case APIResult = "API Result"
            case userIdx
        }
    
}


