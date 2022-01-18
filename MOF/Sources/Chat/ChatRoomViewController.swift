//
//  ChatRoomViewController.swift
//  MOF
//
//  Created by 이현서 on 2021/11/23.
//

import UIKit
class  ChatRoomViewController : UIViewController{
    
    @IBOutlet weak var chatTableView: UITableView!
    
    @IBOutlet weak var largeView: UIView!
    @IBAction func plusButtonAction(_ sender: Any) {
        
        if  largeView.isHidden == false{
            largeView.isHidden = true
        }else{
            largeView.isHidden = false
        }
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        chatTableView.dataSource = self
        chatTableView.delegate = self
    }

    
}

//MARK -: EXTENSION

extension ChatRoomViewController : UITableViewDelegate,UITableViewDataSource{
    
    //HEADER
    func numberOfSections(in tableView: UITableView) -> Int {
            return 3
        }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowInSection = [ 3,1,2]
        return rowInSection[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        
        
        if indexPath.row % 2 == 1{
            
            let myCell = tableView.dequeueReusableCell(withIdentifier: "MyChatTableViewCell", for: indexPath) as! MyChatTableViewCell
            
            myCell.myChatView.layer.cornerRadius = 15
            cell = myCell
            
            
        } else{
            let yourCell = tableView.dequeueReusableCell(withIdentifier: "YourChatTableViewCell", for: indexPath) as! YourChatTableViewCell
            yourCell.yourChatView.layer.cornerRadius = 15
            cell = yourCell
            
            
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "------------------- 0000.00.00 금요일 -------------------"
        
    }

  
    
    //Header height
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 30
        }
    
    
    
}
