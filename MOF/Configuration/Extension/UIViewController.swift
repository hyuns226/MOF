//
//  UIViewController.swift
//  MOF - storyboard
//
//  Created by 이현서 on 2022/01/13.
//

import UIKit
import SnapKit

extension UIViewController {
   
    
    // MARK: 빈 화면을 눌렀을 때 키보드가 내려가도록 처리
    func dismissKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer =
            UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard))
//        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        self.view.endEditing(false)
    }

    
    // MARK: 취소와 확인이 뜨는 UIAlertController
    func presentAlert(title: String, message: String? = nil,
                      isCancelActionIncluded: Bool = false,
                      preferredStyle style: UIAlertController.Style = .alert,
                      handler: ((UIAlertAction) -> Void)? = nil) {
        self.dismissIndicator()
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        let actionDone = UIAlertAction(title: "확인", style: .default, handler: handler)
        alert.addAction(actionDone)
        if isCancelActionIncluded {
            let actionCancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            alert.addAction(actionCancel)
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: 커스텀 UIAction이 뜨는 UIAlertController
    func presentAlert(title: String, message: String? = nil,
                      isCancelActionIncluded: Bool = false,
                      preferredStyle style: UIAlertController.Style = .alert,
                      with actions: UIAlertAction ...) {
        self.dismissIndicator()
        let alert = UIAlertController(title: title, message: message, preferredStyle: style)
        actions.forEach { alert.addAction($0) }
        if isCancelActionIncluded {
            let actionCancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
            alert.addAction(actionCancel)
        }
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: UIWindow의 rootViewController를 변경하여 화면전환
    func changeRootViewController(_ viewControllerToPresent: UIViewController) {
        if let window = UIApplication.shared.windows.first {
            window.rootViewController = viewControllerToPresent
            UIView.transition(with: window, duration: 0.5, options: .transitionCrossDissolve, animations: nil)
        } else {
            viewControllerToPresent.modalPresentationStyle = .overFullScreen
            self.present(viewControllerToPresent, animated: true, completion: nil)
        }
    }
    
    // MARK: 커스텀 하단 경고창
    func presentBottomAlert(message: String, target: ConstraintRelatableTarget? = nil, offset: Double? = -12) {
        let alertSuperview = UIView()
        alertSuperview.backgroundColor = UIColor.black.withAlphaComponent(0.9)
        alertSuperview.layer.cornerRadius = 10
        alertSuperview.isHidden = true
    
        let alertLabel = UILabel()
        alertLabel.font = .NotoSans(.regular, size: 15)
        alertLabel.textColor = .white
        
        self.view.addSubview(alertSuperview)
        alertSuperview.snp.makeConstraints { make in
            make.bottom.equalTo(target ?? self.view.safeAreaLayoutGuide).offset(-12)
            make.centerX.equalToSuperview()
        }
        
        alertSuperview.addSubview(alertLabel)
        alertLabel.snp.makeConstraints { make in
            make.top.equalTo(6)
            make.bottom.equalTo(-6)
            make.leading.equalTo(12)
            make.trailing.equalTo(-12)
        }
        
        alertLabel.text = message
        alertSuperview.alpha = 1.0
        alertSuperview.isHidden = false
        UIView.animate(
            withDuration: 2.0,
            delay: 1.0,
            options: .curveEaseIn,
            animations: { alertSuperview.alpha = 0 },
            completion: { _ in
                alertSuperview.removeFromSuperview()
            }
        )
    }
    
    // MARK: 인디케이터 표시
    func showIndicator() {
        IndicatorView.shared.show()
        IndicatorView.shared.showIndicator()
    }
    
    // MARK: 인디케이터 숨김
    @objc func dismissIndicator() {
        IndicatorView.shared.dismiss()
    }
    
    
    //Date관련 함수
    func stringToDate(dateString : String) -> Date{
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "EEE yy-MM-dd HH:mm"
        let date = formatter.date(from: dateString)!
        return date
    }
    
    func stringToDateAll(dateString : String) -> Date{
        let formatter = DateFormatter()
        formatter.dateFormat = "yy-MM-dd HH:mm"
        let date = formatter.date(from: dateString)!
        return date
    }
    
    func stringToDateForDayandDate(dateString : String) -> Date{
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateFormat = "EEE HH:mm"
        let date = formatter.date(from: dateString)!
        return date
    }
    
    func stringToDateForOneday(dateString : String) -> Date{
        let formatter = DateFormatter()
        formatter.dateFormat = "MM-dd HH:mm"
        let date = formatter.date(from: dateString)
        return date ?? Date()
    }


    func dateToString(date : Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE요일 HH:mm"
        formatter.locale = Locale(identifier: "ko")
        return formatter.string(from: date)
    }
    
    func dateToStringOnlyTime(date : Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
    
    func dateToStringOnlyDay(date : Date) -> String{
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko")
        formatter.dateFormat = "EEE요일"
        return formatter.string(from: date)
    }
    
    func dateToStringOnlyDate(date : Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "M월 dd일"
        return formatter.string(from: date)
    }
    
    func dateToStringOnlyDaySend(date : Date) -> String{
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko")
        formatter.dateFormat = "EEE"
        return formatter.string(from: date)
    }
    
    func dateToStringTimeSend(date : Date) -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "HHmm00"
        return formatter.string(from: date)
    }
    
    
    //네비게이션 바에 back버튼 추가
    func settingBackButton(){
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = .label
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
    }
    func showAuthorizationAlert() {
            //허용안된 상태
            //alert 띄우기
            let alert = UIAlertController(title: "갤러리 접근 권한을 활성화해주세요.", message: nil, preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "닫기", style: .cancel, handler: nil))
            alert.addAction(UIAlertAction(title: "설정으로 가기", style: .default, handler: { action in
                
                //갤러리 접근 권한이 없으면 내 앱에대한 설정으로 이동 코드
                guard let url = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                //열릴수 있나
                if  UIApplication.shared.canOpenURL(url){
                    UIApplication.shared.open(url, options: [:], completionHandler: nil)
                }
            }))
            self.present(alert, animated: true, completion: nil)
        }
        

}


