//
//  AcademyMyPageDataManager.swift
//  MOF
//
//  Created by 이현서 on 2022/02/03.
//

import Alamofire
class AcademyMyPageDataManager{
    //학원 회원가입
    func academy(_ parameters: AcademySignUpRequest, delegate: AcademySignUpSelectGenreViewController) {
        AF.request("\(Constant.BASE_URL)academy", method: .post, parameters: parameters, encoder: JSONParameterEncoder())
            .validate()
            .responseDecodable(of: academySignUpResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.academy(result: response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest()
                }
            }
    }
    
    //학원 마이프로필 정보 조회
    func academyProfile(academyIdx : Int, delegate: AcademyMyProfileViewController) {
        AF.request("\(Constant.BASE_URL)academy/\(academyIdx)", method: .get, parameters: nil, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: academyProfileResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.academyProfile(result: response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest()
                }
            }
    }
    
    //학원 마이프로필 정보 수정
    func academyProfileModify(_ parameters: academyProfileRequest, academyIdx : Int, delegate: AcademyMyProfileViewController) {
        AF.request("\(Constant.BASE_URL)academy/\(academyIdx)", method: .patch, parameters: parameters, encoder: JSONParameterEncoder(), headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: regularResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.profileModify(result: response)
                   
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest()
                }
            }
    }
    
    
    
    
    
    
    
    
}
