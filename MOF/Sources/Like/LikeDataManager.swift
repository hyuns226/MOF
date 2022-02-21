//
//  LikeDataManager.swift
//  MOF
//
//  Created by 이현서 on 2022/02/20.
//

import Alamofire
class LikeDataManager : UIViewController{
    
    //전체 학원 좋아요 조회
    func allAcademyLikes(userIdx : Int , delegate: AcademyViewController) {
        AF.request("\(Constant.BASE_URL)likes/users/academy/\(userIdx)", method: .get, parameters: nil, encoding: JSONEncoding.default,headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: allAcademyLikesResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.allAcademyLikes(result: response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest()
                }
            }
    }
    
    //전체 수업 좋아요 조회
    func allClassLikes(userIdx : Int , delegate: ClassViewController) {
        AF.request("\(Constant.BASE_URL)likes/users/classes/\(userIdx)", method: .get, parameters: nil, encoding: JSONEncoding.default,headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: allClassLikesResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.allClassLikes(result: response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest()
                }
            }
    }
    
    //특정위치 학원 좋아요 조회
    func specificAcademyLikes(userIdx : Int , address: String, delegate: AcademyViewController) {
        let url = "\(Constant.BASE_URL)likes/users/academy/locations/\(userIdx)?address=\(address)"
        let encodedString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let urlResult = URL(string: encodedString)!
        AF.request(urlResult, method: .get, parameters: nil, encoding: JSONEncoding.default,headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: specificaAcademyLikesResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.specificAcademyLikes(result: response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest()
                }
            }
    }
    
    //특정위치 수업 좋아요 조회
    func specificClassLikes(userIdx : Int , address: String, delegate: ClassViewController) {
        let url = "\(Constant.BASE_URL)likes/users/classes/locations/\(userIdx)?address=\(address)"
        let encodedString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let urlResult = URL(string: encodedString)!
        AF.request(urlResult, method: .get, parameters: nil, encoding: JSONEncoding.default,headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: specificaClassLikesResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.specificClassLikes(result: response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest()
                }
            }
    }
    
    
    
    
    
}
