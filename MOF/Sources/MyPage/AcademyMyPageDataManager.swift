//
//  AcademyMyPageDataManager.swift
//  MOF
//
//  Created by 이현서 on 2022/02/03.
//

import Alamofire
import UIKit
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
    
    //수업 추가하기
    func addClass(parameters: addClassRequest,classImage : UIImage?, teacherImage : UIImage?, academyIdx : Int, delegate: AddClassViewController) {
        
        let url = "\(Constant.BASE_URL)classes/\(academyIdx)"
        
        let parameters: [String : Any] = [
            "className": parameters.className,
            "classType": parameters.classType,
            "classPrice": parameters.classPrice,
            "classGernre": parameters.classGernre,
            "classPersonnel": parameters.classPersonnel,
            "classIntro": parameters.classIntro,
            "classTeacherName": parameters.classTeacherName,
            "classTeacherIntro": parameters.classTeacherIntro,
            "classStartTime1": parameters.classStartTime1,
            "classEndTime1": parameters.classEndTime1,
            "classStartTime2": parameters.classStartTime2,
            "classEndTime2": parameters.classEndTime2
        ]
        
        
        
        AF.upload(
            multipartFormData: { multipartFormData in
                for (key, value) in parameters {
                                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
                }
                if classImage?.size.width != 0.0{
                                
                    let ConvertedClassImg = classImage?.jpegData(compressionQuality: 0.1)
                    let name = Date()
                    multipartFormData.append(ConvertedClassImg!, withName: "classImage", fileName: name.fileName, mimeType: "image/jpg")
                }
                if teacherImage?.size.width != 0.0{
                                
                    let ConvertedTeacherImg = teacherImage?.jpegData(compressionQuality: 0.1)
                    let name = Date()
                    multipartFormData.append(ConvertedTeacherImg!, withName: "teacher", fileName: name.fileName, mimeType: "image/jpg")
                }
        },to: url,method: .post, headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: addClassResponse.self) { response in
                switch response.result {
                 case .success(let response):
                    delegate.addClass(result: response)
                 case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest()
                    }
            }
        }
    
    //정규 수업 상세 조회
    func getDetailRegularClasses(classIdx: Int, delegate : DetailClassViewController ) {
        AF.request("\(Constant.BASE_URL)classes/regulars/\(classIdx)", method: .get, parameters: nil, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: detailRegularClassResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.getDetailRegularClass(result: response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest()
                }
            }
    }
    
    //원데이 수업 상세 조회
    func getDetailOnedayClasses(classIdx: Int, delegate : DetailClassViewController ) {
        AF.request("\(Constant.BASE_URL)classes/one-days/\(classIdx)", method: .get, parameters: nil, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: detailOnedayClassResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.getDetailOnedayClass(result: response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest()
                }
            }
    }
    
    //수업 삭제
    func deleteClass(academyIdx : Int,classIdx : Int, delegate: classDeleteAlertViewController) {
        AF.request("\(Constant.BASE_URL)classes/status/\(academyIdx)/\(classIdx)", method: .patch, parameters: nil, encoding: JSONEncoding.default, headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: deleteClassResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.deleteClass(result: response)
                   
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest()
                }
            }
    }
    
    //수업 수정
    func modifyClass(parameters: modifyClassRequest,classImage : UIImage?, teacherImage : UIImage?, academyIdx : Int,classIdx : Int, delegate: ModifyClassViewController) {
        
        let url = "\(Constant.BASE_URL)classes/\(academyIdx)/\(classIdx)"
        
        let parameters: [String : Any] = [
            "className": parameters.className,
            "classType": parameters.classType,
            "classPrice": parameters.classPrice,
            "classGernre": parameters.classGernre,
            "classPersonnel": parameters.classPersonnel,
            "classIntro": parameters.classIntro,
            "classTeacherName": parameters.classTeacherName,
            "classTeacherIntro": parameters.classTeacherIntro,
            "classStartTime1": parameters.classStartTime1,
            "classEndTime1": parameters.classEndTime1,
            "classStartTime2": parameters.classStartTime2,
            "classEndTime2": parameters.classEndTime2,
            "classImgUrl" : parameters.classImgUrl,
            "teacherImgUrl" : parameters.teacherImgUrl
        ]
        
        
        
        AF.upload(
            multipartFormData: { multipartFormData in
                for (key, value) in parameters {
                                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
                }
                if classImage?.size.width != 0.0{
                                
                    let ConvertedClassImg = classImage?.jpegData(compressionQuality: 0.1)
                    let name = Date()
                    multipartFormData.append(ConvertedClassImg!, withName: "classImage", fileName: name.fileName, mimeType: "image/jpg")
                }
                if teacherImage?.size.width != 0.0{
                                
                    let ConvertedTeacherImg = teacherImage?.jpegData(compressionQuality: 0.1)
                    let name = Date()
                    multipartFormData.append(ConvertedTeacherImg!, withName: "teacher", fileName: name.fileName, mimeType: "image/jpg")
                }
        },to: url,method: .patch, headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: modifyClassResponse.self) { response in
                switch response.result {
                 case .success(let response):
                    delegate.modifyClass(result: response)
                 case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest()
                    }
            }
        }
}


    

