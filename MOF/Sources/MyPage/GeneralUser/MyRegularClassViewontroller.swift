//
//  MyRegularClassViewontroller.swift
//  MOF
//
//  Created by 이현서 on 2021/12/02.
//

import UIKit
class MyRegularClassViewontroller : UIViewController{
    
    
    @IBOutlet weak var regularClassTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        regularClassTableView.dataSource = self
        regularClassTableView.delegate = self
    }
        
    
    
    
    
    
    
    
}


extension MyRegularClassViewontroller : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MYRegularClassTableViewCell", for: indexPath) as! MYRegularClassTableViewCell
        
        
        return cell
    }

    
    
}
