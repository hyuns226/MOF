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
    var academyDetailAddress : String //도로명주소
    var academyAddress : String //filtering 위한 주소 ex) 서울광진구
    var academyBuilding : String//상세주소 ex) 광진빌라 606호
    var academyGernre : String
    
}
