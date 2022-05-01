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
    
    func autoLogin(_ parameters: loginRequest, delegate: MainTabBarController) {
        AF.request("\(Constant.BASE_URL)users/login", method: .post, parameters: parameters, encoder: JSONParameterEncoder())
            .validate()
            .responseDecodable(of: loginResponse.self) { response in
                switch response.result {
                case .success(let response):
                    print(response.message)
                    delegate.login(result: response)
                    print("자동로그인 성공")
                    
                case .failure(let error):
                    print(error.localizedDescription)
                   
                }
            }
    }
    
    
    //일반 유저 비밀번호 변경
    func password(_ parameters: passwordRequest, userIndex : Int, delegate: ChangePasswordViewController) {
        AF.request("\(Constant.BASE_URL)users/passwords/\(userIndex)", method: .patch, parameters: parameters, encoder: JSONParameterEncoder(), headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: userPasswordResponse.self) { response in
                switch response.result { 
                case .success(let response):
                    delegate.password(result: response)
                   
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest()
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
    
    //일반 유저 정보 조회 - 마이페이지 메인
     func userProfileForMain(userIdx : Int, delegate: MyPageViewController) {
         print(userIdx)
         print(KeyCenter.header)
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
    func modify(_ parameters: userModifyRequest, image : UIImage?, userIndex : Int, delegate: GeneralMyProfileViewController) {
        
        
        let url = "\(Constant.BASE_URL)users/\(userIndex)"
        
        let parameters: [String : Any] = [
            "userEmail" :parameters.userEmail,
            "userName" : parameters.userName,
            "userPhone" : parameters.userPhone,
            "userAge" : parameters.userAge,
            "userGender" : parameters.userGender,
            "userAddress" : parameters.userAddress,
            "userProfileImgUrl" : parameters.userProfileImgUrl
    
        ]
        
        AF.upload(
            multipartFormData: { multipartFormData in
                for (key, value) in parameters {
                                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
                }
                if image?.size.width != 0.0{
                                
                    let ConvertedProfileImg = image?.jpegData(compressionQuality: 0.01)
                    let name = Date()
                    multipartFormData.append(ConvertedProfileImg!, withName: "image", fileName: name.fileName, mimeType: "image/jpg")
                }
        },to: url,method: .patch, headers: KeyCenter.header)
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
    func profileImg(profileImage : UIImage?, userIndex : Int, delegate: WelcomViewController) {
        
        let url = "\(Constant.BASE_URL)users/profileImg/\(userIndex)"
        
        AF.upload(
            multipartFormData: { multipartFormData in
                if profileImage?.size.width != 0.0{
                                
                    let ConvertedprofileImage = profileImage?.jpegData(compressionQuality: 0.01)
                    let name = Date()
                    multipartFormData.append(ConvertedprofileImage!, withName: "image", fileName: name.fileName, mimeType: "image/jpg")
                }
        },to: url,method: .patch, headers: KeyCenter.header)
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
    
    
    
    
    //유저 정규 수업 리스트 조회 52번
    func regularClass(userIdx : Int, delegate: MyRegularClassViewontroller) {
        AF.request("\(Constant.BASE_URL)enrolls/users/regulars/\(userIdx)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: KeyCenter.header)
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
    
    //유저 원데이 수업 조회 53번
    func onedayClass(userIdx : Int, delegate: MyOnedayViewController) {
        AF.request("\(Constant.BASE_URL)enrolls/users/one-days/\(userIdx)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: userOnedayClassResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.onedayClass(result: response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest()
                }
            }
    }
    
    //유저 특정 유저 특정 수업 등록 정보 조회
    func enrolledInfo(userIdx : Int, enrollIdx : Int, delegate: DetailEnrolledClassViewController) {
        AF.request("\(Constant.BASE_URL)users/enrolls/\(userIdx)/\(enrollIdx)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: userEnrolledInfoResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.enrolledInfo(result: response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest()
                }
            }
    }
    

    
}



