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
    
    //학원 회원탈퇴
    func academyWithdraw(academyIdx : Int, delegate: AcademySettingViewController) {
        AF.request("\(Constant.BASE_URL)academy/status/\(academyIdx)", method: .patch, parameters: nil, encoding: JSONEncoding.default, headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: regularResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.withdraw(result: response)
                   
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest()
                }
            }
    }
    
    //학원 비밀번호 변경
    func password(_ parameters: passwordRequest, academyIdx : Int, delegate: AcademyChangePasswordViewController) {
        AF.request("\(Constant.BASE_URL)academy/passwords/\(academyIdx)", method: .patch, parameters: parameters, encoder: JSONParameterEncoder(), headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: passwordResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.password(result: response)
                   
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest()
                }
            }
    }
    
    //학원 정규클래스 조회
    func academyRegularClass(academyIdx : Int, delegate: AcademyRegularClassViewController) {
        AF.request("\(Constant.BASE_URL)academy/regular-classes/\(academyIdx)", method: .get, parameters: nil, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: academyRegularResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.academyRegularClass(result: response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest()
                }
            }
    }
    
    //학원 원데이 클래스 조회
    func academyOnedayClass(academyIdx : Int, delegate: AcademyOnedayClassViewController) {
        AF.request("\(Constant.BASE_URL)academy/oneday-classes/\(academyIdx)", method: .get, parameters: nil, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: academyOnedayResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.academyOnedayClass(result: response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest()
                }
            }
    }
    
    
}
