//
//  ClassDetailViewController.swift
//  MOF
//
//  Created by 이현서 on 2021/11/16.
//

import UIKit
class ClassDetailViewController : UIViewController{
    
    
    var classIdx = -1
    
    lazy var dataManager = HomeDataManager()
    
    @IBOutlet weak var ClassTimeCollectionView: UICollectionView!
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var AskButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(classIdx)
        
        AskButton.layer.cornerRadius = 18
        registerButton.layer.cornerRadius = 18
            
        //setting Likes Button
        dataManager.getClassLikes(userIdx: KeyCenter.userIndex, classIdx: classIdx, delegate: self)
        
        ClassTimeCollectionView.delegate = self
        ClassTimeCollectionView.dataSource = self
        
    }
    
    //MARK:- FUNCTION
    @IBAction func likeButtonAction(_ sender: Any) {
        likeButton.isSelected =  !likeButton.isSelected
      
        if likeButton.isSelected == true{
            dataManager.likesForClass(userIdx: KeyCenter.userIndex, classIdx: classIdx, delegate: self)
            
            
        }else{
            dataManager.dislikesForClass(userIdx: KeyCenter.userIndex, classIdx: classIdx, delegate: self)
            
        }
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

//MARK:- API
extension ClassDetailViewController{
    
    func getClassLikes(result : getAcademyLikesResponse){
        print(result.result.좋아요여부)
        if result.result.좋아요여부 == true{
            self.likeButton.isSelected = true
            self.likeButton.setImage(#imageLiteral(resourceName: "heart_fill"), for: .selected)
            print("yes")
        }else{
            self.likeButton.isSelected = false
            self.likeButton.setImage(#imageLiteral(resourceName: "coolicon295"), for: .normal)
            print("no")
        }
    }
    
    func likesForClass(result: classLikeResponse){
        if result.isSuccess{
            likeButton.setImage(#imageLiteral(resourceName: "heart_fill"), for: .selected)
            
            print(likeButton.isSelected)
            print("좋아요")
        }else{
            presentAlert(title: result.message)
        }
        
    }
    
    func dislikesForClass(result: classDislikeResponse){
        if result.isSuccess{
            likeButton.setImage(#imageLiteral(resourceName: "coolicon295"), for: .normal)
            print(likeButton.isSelected)
            print("좋아요취소")
        }else{
            presentAlert(title: result.message)
        }
        
        
    }
    
    
    
    func failedToRequest(){
        
        self.presentAlert(title: "서버와의 연결이 원활하지 않습니다")
    
    }
    
    
}
