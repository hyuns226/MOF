//
//  academyProfileRequest.swift
//  MOF
//
//  Created by 이현서 on 2022/02/09.
//

import Foundation
import UIKit

struct academyProfileRequest : Encodable{
    var academyEmail : String
    var academyName : String
    var academyPhone : String
    var academyAddress : String
    var academyDetailAddress : String
    var academyBuilding : String
    var academyGernre : String
    var profileImgUrl : String
}
