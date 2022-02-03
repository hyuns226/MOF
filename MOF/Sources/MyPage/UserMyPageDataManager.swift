//
//  MyPageDataManager.swift
//  MOF
//
//  Created by 이현서 on 2022/01/08.
//

import Alamofire
class UserMyPageDataManager{
    //일반 유저 회원가입
    func users(_ parameters: usersRequest, delegate: SignUpViewController) {
        AF.request("\(Constant.BASE_URL)users", method: .post, parameters: parameters, encoder: JSONParameterEncoder())
            .validate()
            .responseDecodable(of: usersResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.users(result: response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    //전체 유저 로그인
    func login(_ parameters: loginRequest, delegate: SIgnInViewController) {
        AF.request("\(Constant.BASE_URL)users/login", method: .post, parameters: parameters, encoder: JSONParameterEncoder())
            .validate()
            .responseDecodable(of: loginResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.login(result: response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest()
                }
            }
    }
    
    
    //일반 유저 비밀번호 변경
    func password(_ parameters: passwordRequest, userIndex : Int, delegate: changePasswordViewController) {
        AF.request("\(Constant.BASE_URL)users/passwords/\(userIndex)", method: .patch, parameters: parameters, encoder: JSONParameterEncoder(), headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: usersResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.password(result: response)
                   
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    
    //일반 유저 회원 탈퇴
    func status(userIndex : Int, delegate: GeneralSettingViewController) {
        AF.request("\(Constant.BASE_URL)users/status/\(userIndex)", method: .patch, parameters: nil, encoding: JSONEncoding.default, headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: statusResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.status(result: response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
    //일반 유저 로그인
    func login(_ parameters: loginRequest, delegate: SignUpViewController) {
        AF.request("\(Constant.BASE_URL)users/login", method: .post, parameters: parameters, encoder: JSONParameterEncoder())
            .validate()
            .responseDecodable(of: loginResponse.self) { response in
                switch response.result {
                case .success(let response):
                   // delegate.login(result: response)
                    print("")
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest(message: "서버와의 연결이 원활하지 않습니다")
                }
            }
    }
    
   //일반 유저 정보 조회
    func userProfile(userIdx : Int, delegate: GeneralMyProfileViewController) {
        AF.request("\(Constant.BASE_URL)users/\(userIdx)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: userProfileResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.userProfile(result: response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest()
                }
            }
    }
    
    

    
    //일반 유저 정보 수정
    func modify(_ parameters: userModifyRequest, userIndex : Int, delegate: GeneralMyProfileViewController) {
        AF.request("\(Constant.BASE_URL)users/\(userIndex)", method: .patch, parameters: parameters, encoder: JSONParameterEncoder())
            .validate()
            .responseDecodable(of: userModifyResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.modify(result: response)
                   
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest()
                }
            }
    }
    
    //유저 프로필 이미지
    func profileImg(_ parameters: userProfileImageRequest, userIndex : Int, delegate: WelcomViewController) {
        AF.request("\(Constant.BASE_URL)users/profileImg/\(userIndex)", method: .patch, parameters: parameters, encoder: JSONParameterEncoder())
                .validate()
                .responseDecodable(of: commonResponse.self) { response in
                    switch response.result {
                    case .success(let response):
                        delegate.profileImg(result: response)
                    case .failure(let error):
                        print(error.localizedDescription)
                        delegate.failedToRequest()
                    }
                }
        }
    
    //유저 정규 수업 조회
    func regularClass(userIdx : Int, delegate: MyRegularClassViewontroller) {
        AF.request("\(Constant.BASE_URL)users/regular-class-enrolls/\(userIdx)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: userRegularClassResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.regularClass(result: response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest()
                }
            }
    }
    

    
}



