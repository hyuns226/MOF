//
//  ClassViewController.swift
//  MOF
//
//  Created by 이현서 on 2021/12/02.
//

import UIKit
class ClassViewController : UIViewController{
    
    lazy var dataManager = LikeDataManager()
    
    var classLikeList : [allClassLikesResults?] = []
    var filterdClassLikeList : [specificClassLikesResults?] = []
    
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var emptyViewLabel: UILabel!
    @IBOutlet weak var ClassCollectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        print("classwill")
        if KeyCenter.userType == "general"{
            
            if LikeViewController.isFitered == true{
                dataManager.specificClassLikes(userIdx: KeyCenter.userIndex, address: LikeViewController.filterText, delegate: self)
            }else{
                dataManager.allClassLikes(userIdx: KeyCenter.userIndex, delegate: self)
            }
        }
       
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        print("classdid")
        self.ClassCollectionView.dataSource = self
        self.ClassCollectionView.delegate = self
    }
    
    
}

extension ClassViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if LikeViewController.isFitered == true{
            if filterdClassLikeList.count == 0{
                emptyViewLabel.text = "좋아요한 수업이 없습니다"
                emptyView.isHidden = false
                
                return 0
            }else{
                emptyView.isHidden = true
                emptyViewLabel.text = "로그인후 좋아요 목록을 확인해보세요!"
                return filterdClassLikeList.count
            }
            
        }else{
            if classLikeList.count == 0 && KeyCenter.userType != ""{
                emptyViewLabel.text = "좋아요한 수업이 없습니다"
                emptyView.isHidden = false
                print("5번여기")
                return 0
            }else if KeyCenter.userType == ""{
                emptyView.isHidden = false
                emptyViewLabel.text = "로그인후 좋아요 목록을 확인해보세요!"
                return 0
                
            }else{
                emptyView.isHidden = true
                emptyViewLabel.text = "로그인후 좋아요 목록을 확인해보세요!"
                return classLikeList.count
            }
        }
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ClassCollectionViewCell", for: indexPath) as! ClassCollectionViewCell
        cell.layer.cornerRadius = 6
        
        
        if LikeViewController.isFitered == true{
            if let url = URL(string: filterdClassLikeList[indexPath.row]?.classImageUrl ?? "") {
                cell.classImageView.kf.setImage(with: url)
            } else {
                cell.classImageView.image = UIImage(named: "defaultImage")
            }
            
            cell.classNameLabel.text = filterdClassLikeList[indexPath.row]?.className
            
        }else{
            if let url = URL(string: classLikeList[indexPath.row]?.classImageUrl ?? "") {
                cell.classImageView.kf.setImage(with: url)
            } else {
                cell.classImageView.image = UIImage(named: "defaultImage")
            }
            
            cell.classNameLabel.text = classLikeList[indexPath.row]?.className
            cell.likeButton.isSelected = true
            cell.likeButton.setImage(#imageLiteral(resourceName: "heart_fill"), for: .selected)
            
           
        }
        
        cell.likeButton.isSelected = true
        cell.likeButton.setImage(#imageLiteral(resourceName: "heart_fill"), for: .selected)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let homeStoryBoard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        let detailVC = homeStoryBoard.instantiateViewController(withIdentifier: "ClassDetailViewController")as!ClassDetailViewController
        
        if LikeViewController.isFitered == true{
            detailVC.classIdx = filterdClassLikeList[indexPath.row]?.classIdx ?? 0
            detailVC.classType = filterdClassLikeList[indexPath.row]?.classType ?? ""
            detailVC.fromeLike = true
           
        }else{
            detailVC.classIdx = classLikeList[indexPath.row]?.classLikeClassIdx ?? 0
            detailVC.classType = classLikeList[indexPath.row]?.classType ?? ""
            detailVC.fromeLike = true
        
            
        }
        
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
    
//MARK-: COLLECTIONVIEW FLOWLAYOUT
extension ClassViewController : UICollectionViewDelegateFlowLayout{
    
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
extension ClassViewController{
    func allClassLikes(result : allClassLikesResponse){
        print(result)
        if result.isSuccess{
            classLikeList = result.result
            print(classLikeList)
            ClassCollectionView.reloadData()
        }else{
            presentAlert(title: result.message)
        }
        
    }
    
    func specificClassLikes(result : specificaClassLikesResponse){
        print(result)
        if result.isSuccess{
            filterdClassLikeList = result.result
            print(filterdClassLikeList)
            ClassCollectionView.reloadData()
        }else{
            presentAlert(title: result.message)
        }
        
    }
    
    func failedToRequest(){
        
        self.presentAlert(title: "서버와의 연결이 원활하지 않습니다")
    
    }
    
}

