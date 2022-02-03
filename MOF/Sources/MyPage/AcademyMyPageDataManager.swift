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
    
    
    
    
    
    
    
    
}
