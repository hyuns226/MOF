//
//  DetaliPageViewController.swift
//  MOF
//
//  Created by 이현서 on 2021/11/16.
//

import UIKit
class AcademyDetaliViewController : UIViewController {
    
    //@IBOutlet weak var RegularClassTableView: UITableView!
    
    //@IBOutlet weak var OnedayClassTableView: UITableView!
    
    @IBOutlet weak var regularClassTableView: UITableView!
    
    @IBOutlet weak var OnedayClassTableView: UITableView!
    
    @IBOutlet weak var OtherClassCollectionView: UICollectionView!
    @IBOutlet weak var AskButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    
        
        
   
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //setting tavleview,collectionview
        regularClassTableView.delegate = self
        regularClassTableView.dataSource = self
        OnedayClassTableView.delegate = self
        OnedayClassTableView.dataSource = self
        OtherClassCollectionView.dataSource = self
        OtherClassCollectionView.delegate = self
        
        
        //setting button
        AskButton.layer.cornerRadius = 18
        registerButton.layer.cornerRadius = 18
            
        
    }
    
    
}


//MARK:- EXTENSION

extension AcademyDetaliViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        if tableView == regularClassTableView{
            cell = tableView.dequeueReusableCell(withIdentifier: "RegularClassTableViewCell") as! RegularClassTableViewCell
            cell.separatorInset = UIEdgeInsets.zero
            
        }else{
            cell = tableView.dequeueReusableCell(withIdentifier: "OnedayClassTableViewCell") as! OnedayClassTableViewCell
            cell.separatorInset = UIEdgeInsets.zero
        }
         
        return  cell
    }

    // MARK: - Table View delegate methods

        func numberOfSections(in tableView: UITableView) -> Int {
            return 3
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

extension AcademyDetaliViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OtherAcademyCollectionViewCell", for: indexPath)  as! OtherAcademyCollectionViewCell
        
        return cell
         
    }
    
    

    
    
}

