//
//  EnrollDataManager.swift
//  MOF
//
//  Created by 이현서 on 2022/03/13.
//
import Alamofire
class EnrollDataManager : UIViewController{
    
    //학원 정규클래스 조회
    func academyRegularClass(academyIdx : Int, delegate: EnrollRegularClassViewController) {
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
    func academyOnedayClass(academyIdx : Int, delegate: EnrollOnedayClassViewController) {
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
    
    //특정 수업 신청 조회
    func classEnrolls(academyIdx : Int, classIdx : Int,  delegate: DetailEnrollListViewController) {
        AF.request("\(Constant.BASE_URL)enrolls/academy/\(academyIdx)/\(classIdx)", method: .get, parameters: nil, encoding: JSONEncoding.default, headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: detailEnrollsResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.classEnrolls(result: response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest()
                }
            }
    }
    
    //학원유저 수업 승인
    func approveClass(academyIdx : Int, enrollIdx : Int, delegate: DetailEnrollListViewController ) {
        AF.request("\(Constant.BASE_URL)enrolls/submit/\(academyIdx)/\(enrollIdx)", method: .patch, parameters: nil, encoding: JSONEncoding.default, headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: approveResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.approveClass(result: response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest()
                }
            }
    }
    
    //학원유저 수업 거절
    func rejectClass(academyIdx : Int, enrollIdx : Int, delegate: DetailEnrollListViewController ) {
        AF.request("\(Constant.BASE_URL)enrolls/reject/\(academyIdx)/\(enrollIdx)", method: .patch, parameters: nil, encoding: JSONEncoding.default, headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: approveResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.rejectClass(result: response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest()
                }
            }
    }
}
