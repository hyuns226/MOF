//
//  kakaoPostCodeViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/03/23.
//

import Foundation
import UIKit
import WebKit
class kakaoPostCodeViewController : UIViewController{
    var webView: WKWebView?
    var roadAddress = ""
    var jibunAddress = ""
    var zonecode = ""
    var sido = ""
    var sigungu = ""
    
    var delegate : kakaoPostCodeProtocol?
    
    override func viewDidLoad() {
     
        let contentController = WKUserContentController()
        contentController.add(self, name: "callBackHandler")
        
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = contentController
        
        webView = WKWebView(frame: .zero, configuration: configuration)
        
        webView?.navigationDelegate = self
        
        guard let url = URL(string: "https://hyuns226.github.io/MOF-Kakao-Postcode/"),
            let webView = webView
            else { return }
        let request = URLRequest(url: url)
        webView.load(request)
        //showIndicator()
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
       

        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }
    
    
    
    
    
    
    
}

extension kakaoPostCodeViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        //유저가 주소를 검색하고 어떤 값을 최종적으로 선택했을 때 호출
       
        if let data = message.body as? [String: Any] {
            print(data)
            roadAddress = data["roadAddress"] as? String ?? ""
            jibunAddress = data["jibunAddress"] as? String ?? ""
            zonecode = data["zonecode"] as? String ?? ""
            sido = data["sido"] as? String ?? ""
            sigungu = data["sigungu"] as? String ?? ""
           
        }
        
        if sido == "경기"{
            let sigungu_list = sigungu.split(separator: " ")
            sigungu = String(sigungu_list[0])
        }
        
        if sido == "제주특별자치도"{
            sido = "제주"
        }
        
        let previousVC = self.storyboard?.instantiateViewController(withIdentifier: "AcademySignUpViewController")as!AcademySignUpViewController
        print(sido+sigungu)
        delegate?.sendPostCode(forShow: roadAddress, forSend: roadAddress, addressForSearch: sido+sigungu)
        self.dismiss(animated: true, completion: nil)

    }
    
    
}

extension kakaoPostCodeViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        showIndicator()
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
       dismissIndicator()
    }
}
