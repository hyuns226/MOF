//
//  ClassDetailViewController.swift
//  MOF
//
//  Created by 이현서 on 2021/11/16.
//

import UIKit
class ClassDetailViewController : UIViewController{
    
    @IBOutlet weak var ClassTimeCollectionView: UICollectionView!
    
    @IBOutlet weak var AskButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AskButton.layer.cornerRadius = 18
        registerButton.layer.cornerRadius = 18
            
        
        ClassTimeCollectionView.delegate = self
        ClassTimeCollectionView.dataSource = self
        
    }
}

extension ClassDetailViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClassTimeCollectionViewCell", for: indexPath) as! ClassTimeCollectionViewCell
           cell.layer.borderColor = #colorLiteral(red: 0.9341395497, green: 0.9341614842, blue: 0.9341497421, alpha: 1)
           cell.layer.borderWidth = 1
        return cell
    }
    
    
    
    
    
    
    
    
    
    
    
}
