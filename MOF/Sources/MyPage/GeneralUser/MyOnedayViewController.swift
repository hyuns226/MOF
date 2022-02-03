//
//  MyOnedayViewController.swift
//  MOF
//
//  Created by 이현서 on 2021/12/02.
//

import UIKit
class MyOnedayViewController : UIViewController{
    
    lazy var dataManager = UserMyPageDataManager()
    var ondayClasses : [onedayResults?] = []
    
    @IBOutlet weak var ondayClassTableView: UITableView!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLoad()
        
        ondayClassTableView.dataSource = self
        ondayClassTableView.delegate = self
        
        dataManager.onedayClass(userIdx: KeyCenter.userIndex, delegate: self)
    }
    
    
    

}

//MARK:-EXTENSION
extension MyOnedayViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ondayClasses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MYOnedayClassTableViewCell", for: indexPath) as! MYOnedayClassTableViewCell
        
        cell.academyNameLabel.text = ondayClasses[indexPath.row]?.className
        cell.teacherNameLabel.text = ondayClasses[indexPath.row]?.classTeacherName
        
        //클래스 시간 정보 없음..
    //        cell.timeOneLabel.text =regularClasses[indexPath.row].classTeacherName
    //
        return cell
    }
    
    
   
}


//MARK: - API
extension MyOnedayViewController{
    
    
    func onedayClass(result : userOnedayClassResponse){
        if result.isSuccess == true{
            print(result)
            ondayClasses = result.result ?? []
            ondayClassTableView.reloadData()
            
            
        }else{
            self.presentAlert(title: result.message)
            
        }
    
    }
    
    func failedToRequest(){
        
        self.presentAlert(title: "서버와의 연결이 원활하지 않습니다")
    
    }
    
    
}
