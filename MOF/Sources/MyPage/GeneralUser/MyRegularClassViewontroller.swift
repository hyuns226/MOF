//
//  MyRegularClassViewontroller.swift
//  MOF
//
//  Created by 이현서 on 2021/12/02.
//

import UIKit
class MyRegularClassViewontroller : UIViewController{
    
    lazy var dataManager = UserMyPageDataManager()
    
    var regularClasses : [regularResults?] = []

    
    @IBOutlet weak var regularClassTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        regularClassTableView.dataSource = self
        regularClassTableView.delegate = self
        
        dataManager.regularClass(userIdx: KeyCenter.userIndex, delegate: self)
    }
        
    
    
    
    
    
    
    
}


extension MyRegularClassViewontroller : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return regularClasses.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MYRegularClassTableViewCell", for: indexPath) as! MYRegularClassTableViewCell
        
        cell.academyNameLabel.text = regularClasses[indexPath.row]?.className
        cell.teacherNameLabel.text = regularClasses[indexPath.row]?.classTeacherName
        
        //클래스 시간 정보 없음..
//        cell.timeOneLabel.text =regularClasses[indexPath.row].classTeacherName
//
        
        
        return cell
    }

    
    
}


//MARK: - API
extension MyRegularClassViewontroller{
    
    
    func regularClass(result : userRegularClassResponse){
        if result.isSuccess == true{
            print(result)
            
            regularClasses = result.result ?? []
            regularClassTableView.reloadData()
            
            
        }else{
            self.presentAlert(title: result.message)
            
        }
    
    }
    
    func failedToRequest(){
        
        self.presentAlert(title: "서버와의 연결이 원활하지 않습니다")
    
    }
    
    
}
