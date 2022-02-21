//
//  keyCenter.swift
//  MOF
//
//  Created by 이현서 on 2022/01/13.
//

// MARK: Secret 폴더 안에서 사용하는 파일들은 .gitignore에 추가하기
import Alamofire

struct KeyCenter {
    static var LOGIN_TOKEN = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWR4IjoxMiwiaWF0IjoxNjQzODY3OTMwLCJleHAiOjE2NzU0MDM5MzAsInN1YiI6InVzZXJJbmZvIn0.QKLIKCtuq4sEOBfPp0SqS3BWMuOGny-3NC7PUZNmUs0"

    static let header: HTTPHeaders = ["X-ACCESS-TOKEN": "\(KeyCenter.LOGIN_TOKEN)"]
    
    static var userIndex = 12
    
}
