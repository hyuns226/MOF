//
//  keyCenter.swift
//  MOF
//
//  Created by 이현서 on 2022/01/13.
//

// MARK: Secret 폴더 안에서 사용하는 파일들은 .gitignore에 추가하기
import Alamofire

struct KeyCenter {
    static var LOGIN_TOKEN = ""

    static var header: HTTPHeaders = ["X-ACCESS-TOKEN": "\(KeyCenter.LOGIN_TOKEN)"]
    
    static var userIndex = -1
    static var userType = "" //1.general, 2.academy
    
}
