//
//  commonResponse.swift
//  MOF
//
//  Created by 이현서 on 2022/01/14.
//

struct commonResponse : Decodable{
    var isSuccess : Bool
    var code : Int
    var message : String
}
