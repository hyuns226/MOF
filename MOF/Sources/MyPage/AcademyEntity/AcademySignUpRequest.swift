//
//  AcademyInput.swift
//  MOF
//
//  Created by 이현서 on 2022/01/18.
//

struct AcademySignUpRequest : Encodable{
    
    var image : String?
    var academyEmail : String
    var academyPWD : String
    var academyName : String
    var academyPhone : String
    var academyDetailAddress : String
    var academyAddress : String
    var academyGernre : String
    
}
