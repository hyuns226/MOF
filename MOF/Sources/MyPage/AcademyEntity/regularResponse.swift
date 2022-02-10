//
//  regularResponse.swift
//  MOF
//
//  Created by 이현서 on 2022/02/09.
//

import Foundation
struct regularResponse : Decodable{
    
    var isSuccess  : Bool
    var code : Int
    var message : String
    
}
