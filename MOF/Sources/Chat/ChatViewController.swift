//
//  ChatViewController.swift
//  MOF
//
//  Created by 이현서 on 2021/11/23.
//

import Foundation
import UIKit
class ChatViewController : UIViewController{
    
    @IBOutlet weak var ChattingTitle: UIBarButtonItem!
    @IBOutlet weak var ChatTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpChattingTitle()
        ChatTableView.delegate = self
        ChatTableView.dataSource = self
    
    }
    
    func setUpChattingTitle(){
        let chatTitle = UILabel()
        chatTitle.frame = CGRect(x: 0.0, y: 0.0, width: 60, height: 30)
        chatTitle.text = "채팅"
        chatTitle.textColor = #colorLiteral(red: 0.9450980392, green: 0, blue: 0.6862745098, alpha: 1)
        chatTitle.font = UIFont(name:"NotoSansCJKkr-Bold" , size: 21)
        
    


        let menuBarItem = UIBarButtonItem(customView: chatTitle)
        let currWidth = menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 60)
        currWidth?.isActive = true
        let currHeight = menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 30)
        currHeight?.isActive = true
        self.navigationItem.leftBarButtonItem = menuBarItem
    }

    
    
}

extension ChatViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "ChattingTableViewCell", for: indexPath) as!  ChattingTableViewCell
        
        return cell
        
    }
    

    
    
}
