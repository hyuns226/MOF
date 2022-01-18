//
//  PopinViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/01/05.
//

import UIKit
class PopinViewController : UIViewController{
    
    @IBOutlet weak var PopinTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        PopinTableView.delegate = self
        PopinTableView.dataSource = self
    }

}

//MARK:- EXTENSION
extension PopinViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PopinTableViewCell")as!PopinTableViewCell
        cell.layer.cornerRadius = 12
        return cell
    }
    
    // MARK: - Table View delegate methods

        func numberOfSections(in tableView: UITableView) -> Int {
            return 5
        }

        
        // Set the spacing between sections
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 15
        }

        // Make the background color show through
        func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
            let headerView = UIView()
            headerView.backgroundColor = UIColor.clear
            return headerView
        }
    
    
    

}
