//
//  academyProfileRequest.swift
//  MOF
//
//  Created by 이현서 on 2022/02/09.
//

import Foundation
struct academyProfileRequest : Encodable{
    
    var image : Data?
    var academyEmail : String
    var academyName : String
    var academyPhone : String
    var academyAddress : String
    var academyDetailAddress : String
    var academyGernre : String
    var profileImgUrl : String
}
