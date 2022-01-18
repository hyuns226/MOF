//
//  statusResponse.swift
//  MOF
//
//  Created by 이현서 on 2022/01/13.
//

struct statusResponse : Decodable{
    var isSuccess : Bool
    var code : Int
    var message : String
    
}
