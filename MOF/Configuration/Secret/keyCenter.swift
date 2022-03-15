//
//  keyCenter.swift
//  MOF
//
//  Created by 이현서 on 2022/01/13.
//

// MARK: Secret 폴더 안에서 사용하는 파일들은 .gitignore에 추가하기
import Alamofire

struct KeyCenter {
    static var LOGIN_TOKEN = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJhY2FkZW15SWR4IjoxMCwiaWF0IjoxNjQ3MTQ3MDQyLCJleHAiOjE2Nzg2ODMwNDIsInN1YiI6ImFjYWRlbXlJbmZvIn0.xEOAjwM9ZCNJpIuboFJTvFlDln40BU1qbjnXgmmRBq8"

    static let header: HTTPHeaders = ["X-ACCESS-TOKEN": "\(KeyCenter.LOGIN_TOKEN)"]
    
    static var userIndex = 10
    static var userType = "academy" //1.general, 2.academy
    
}
