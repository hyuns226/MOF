//
//  HomeDataManager.swift
//  MOF
//
//  Created by 이현서 on 2022/01/13.
//

import Alamofire
class HomeDataManager{
    
    //전체 학원 조회
    func allGenre(delegate: AllViewController) {
        AF.request("\(Constant.BASE_URL)academy", method: .get, parameters: nil, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: allGenreResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.allGenre(result: response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest()
                }
            }
    }
    
    //특정 장르 학원 조회
    func specificGenre(genre : String, delegate: HomeViewController) {
        AF.request("\(Constant.BASE_URL)acd/gernres?gernre=\(genre)", method: .get, parameters: nil, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: specificGenreResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.specificGenre(result: response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest()
                }
            }
    }
    
    //전체 학원 특정 위치 학원 조회
    func allGenreSpecificLocation(address : String, delegate: HomeViewController) {
        AF.request("\(Constant.BASE_URL)acd/locations?address=\(address)", method: .get, parameters: nil, encoding: JSONEncoding.default)
            .validate()
            .responseDecodable(of: specificGenreResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.allGenreSpecificLocation(result: response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest()
                }
            }
    }
    
    //학원 좋아요
    func likesForAcademy(userIdx : Int, academyIdx : Int, delegate: AcademyDetaliViewController ) {
        AF.request("\(Constant.BASE_URL)likes/academy/\(userIdx)/\(academyIdx)", method: .post, parameters: nil, encoding: JSONEncoding.default, headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: likeResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.likesForAcademy(result: response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest()
                }
            }
    }
    
    //학원 좋아요 취소
    func dislikesForAcademy(userIdx : Int, academyIdx : Int, delegate: AcademyDetaliViewController ) {
        AF.request("\(Constant.BASE_URL)likes/academy/\(userIdx)/\(academyIdx)", method: .patch, parameters: nil, encoding: JSONEncoding.default, headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: dislikeResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.dislikesForAcademy(result: response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest()
                }
            }
    }
    
    //특정 유저의 특정학원 좋아요 여부
    func getAcademyLikes(userIdx : Int, academyIdx: Int, delegate : AcademyDetaliViewController ) {
        AF.request("\(Constant.BASE_URL)users/academy/likes/\(userIdx)/\(academyIdx)", method: .get, parameters: nil, encoding: JSONEncoding.default,headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: getAcademyLikesResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.getAcademyLikes(result: response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest()
                }
            }
    }
    
    //학원 정규클래스 조회
    func academyRegularClass(academyIdx : Int, delegate: AcademyDetaliViewController) {
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
    func academyOnedayClass(academyIdx : Int, delegate: AcademyDetaliViewController) {
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

    //수업 좋아요
    func likesForClass(userIdx : Int, classIdx : Int, delegate: ClassDetailViewController ) {
        AF.request("\(Constant.BASE_URL)likes/classes/\(userIdx)/\(classIdx)", method: .post, parameters: nil, encoding: JSONEncoding.default, headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: classLikeResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.likesForClass(result: response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest()
                }
            }
    }
    
    //수업 좋아요 취소
    func dislikesForClass(userIdx : Int, classIdx : Int, delegate: ClassDetailViewController ) {
        AF.request("\(Constant.BASE_URL)likes/classes/\(userIdx)/\(classIdx)", method: .patch, parameters: nil, encoding: JSONEncoding.default, headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: classDislikeResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.dislikesForClass(result: response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest()
                }
            }
    }
    
    //특정 유저의 특정수업 좋아요 여부
    func getClassLikes(userIdx : Int, classIdx: Int, delegate : ClassDetailViewController ) {
        AF.request("\(Constant.BASE_URL)users/classes/likes/\(userIdx)/\(classIdx)", method: .get, parameters: nil, encoding: JSONEncoding.default,headers: KeyCenter.header)
            .validate()
            .responseDecodable(of: getAcademyLikesResponse.self) { response in
                switch response.result {
                case .success(let response):
                    delegate.getClassLikes(result: response)
                case .failure(let error):
                    print(error.localizedDescription)
                    delegate.failedToRequest()
                }
            }
    }
    
    //정규 수업 상세 조회
    func getDetailRegularClasses(classIdx: Int, delegate : ClassDetailViewController ) {
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
    
    //정규 수업 상세 조회
    func getDetailOnedayClasses(classIdx: Int, delegate : ClassDetailViewController ) {
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
    
}
