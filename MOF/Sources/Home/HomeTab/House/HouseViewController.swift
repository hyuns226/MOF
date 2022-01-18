//
//  HouseViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/01/05.
//

import UIKit
class HouseViewController : UIViewController{
    
    @IBOutlet weak var HouseTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        HouseTableView.dataSource = self
        HouseTableView.delegate = self
    }
    
}

//MARK:- EXTENSION
extension HouseViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HouseTableViewCell")as!HouseTableViewCell
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
