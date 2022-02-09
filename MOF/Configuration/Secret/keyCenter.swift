//
//  keyCenter.swift
//  MOF
//
//  Created by 이현서 on 2022/01/13.
//

// MARK: Secret 폴더 안에서 사용하는 파일들은 .gitignore에 추가하기
import Alamofire

struct KeyCenter {
    static var LOGIN_TOKEN = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWR4IjoxOCwiaWF0IjoxNjQyMDY3NzU1LCJleHAiOjE2NzM2MDM3NTUsInN1YiI6InVzZXJJbmZvIn0.zY88unwkwBXk8yDORbwBMuVacZdxXDuPq18It9MT2WA"

    static let header: HTTPHeaders = ["X-ACCESS-TOKEN": "\(KeyCenter.LOGIN_TOKEN)"]
    
    static var userIndex = 12
    
}
