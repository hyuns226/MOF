//
//  userModifyResponse.swift
//  MOF
//
//  Created by 이현서 on 2022/01/13.
//

struct userModifyResponse : Decodable{
    var isSuccess : Bool
    var code : Int
    var message : String
}
