//
//  keyCenter.swift
//  MOF
//
//  Created by 이현서 on 2022/01/13.
//

// MARK: Secret 폴더 안에서 사용하는 파일들은 .gitignore에 추가하기
import Alamofire

struct KeyCenter {
    static var LOGIN_TOKEN = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhY2FkZW15SWR4IjoxMiwiaWF0IjoxNjQ0NDA0OTMzLCJleHAiOjE2NzU5NDA5MzMsInN1YiI6ImFjYWRlbXlJbmZvIn0.8biP8kXF--7e_zxhkKtUBFTFnrhnyszkeuHt853v3GY"

    static let header: HTTPHeaders = ["X-ACCESS-TOKEN": "\(KeyCenter.LOGIN_TOKEN)"]
    
    static var userIndex = 12
    
}
