//
//  LikeViewController.swift
//  MOF
//
//  Created by 이현서 on 2021/12/02.
//

import UIKit




class AcademyViewController : UIViewController {
    
    lazy var dataManager = LikeDataManager()
    
    var academyLikeList : [allAcademyLikesResults?] = []
    var filterdAcademyLikeList : [specificAcademyLikesResults?] = []
    
    @IBOutlet weak var AcademyCollectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        print("academywill")
        
        if LikeViewController.isFitered == true{
            dataManager.specificAcademyLikes(userIdx: 12, address: LikeViewController.filterText, delegate: self)
        }else{
            dataManager.allAcademyLikes(userIdx: 12, delegate: self)
        }
        
    }
    override func viewDidLoad() {
        print("academydid")
        super.viewDidLoad()
        self.AcademyCollectionView.dataSource = self
        self.AcademyCollectionView.delegate = self
    }
    
    
}

extension AcademyViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if LikeViewController.isFitered == true{
            return filterdAcademyLikeList.count
        }else{
            return academyLikeList.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AcademyCollectionViewCell", for: indexPath) as! AcademyCollectionViewCell
        cell.layer.cornerRadius = 6
        
        if LikeViewController.isFitered == true{
            if let url = URL(string: filterdAcademyLikeList[indexPath.row]?.academyBackImgUrl ?? "") {
                cell.academyImageView.kf.setImage(with: url)
            } else {
                cell.academyImageView.image = UIImage(named: "defaultImage")
            }
            
            cell.academyNameLabel.text = filterdAcademyLikeList[indexPath.row]?.academyName
            
        }else{
            if let url = URL(string: academyLikeList[indexPath.row]?.academyBackImgUrl ?? "") {
                cell.academyImageView.kf.setImage(with: url)
            } else {
                cell.academyImageView.image = UIImage(named: "defaultImage")
            }
            
            cell.academyNameLabel.text = academyLikeList[indexPath.row]?.academyName
           
        }
        
        cell.likeButton.isSelected = true
        cell.likeButton.setImage(#imageLiteral(resourceName: "heart_fill"), for: .selected)
        
        
        
        return cell
    }
}
    
//MARK-: COLLECTIONVIEW FLOWLAYOUT
extension AcademyViewController : UICollectionViewDelegateFlowLayout{
    
    //  위 아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
        
    }

    // 옆 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
        return 10
    }

    // cell 사이즈( 옆 라인을 고려하여 설정 )
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var height : CGFloat = 0
        var width : CGFloat = 0
        var size : CGSize = CGSize(width: 0,height: 0)
        
        width = (collectionView.frame.width - 10) / 2
        height = width
        size = CGSize(width: width, height: height)
                
        
        return size
    }
    
}


//MARK:-API
extension AcademyViewController{
    func allAcademyLikes(result : allAcademyLikesResponse){
        academyLikeList = result.result
        print(academyLikeList)
        AcademyCollectionView.reloadData()
    }
    
    func specificAcademyLikes(result : specificaAcademyLikesResponse){
        filterdAcademyLikeList = result.result
        print(filterdAcademyLikeList)
        AcademyCollectionView.reloadData()
    }
    
    
    
    func failedToRequest(){
        
        self.presentAlert(title: "서버와의 연결이 원활하지 않습니다")
    
    }
    
}

