//
//  LikeViewController.swift
//  MOF
//
//  Created by 이현서 on 2021/12/02.
//

import UIKit




class AcademyViewController : UIViewController {
    
    lazy var dataManager = LikeDataManager()
    
    var academyLikeList : [allAcademyLikesResults] = []
    var filterdAcademyLikeList : [specificAcademyLikesResults] = []
    
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var emptyViewLabel: UILabel!
    @IBOutlet weak var AcademyCollectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        print("academywill")
        print(KeyCenter.userType)
        if KeyCenter.userType == "general"{
            
            if LikeViewController.isFitered == true{
                dataManager.specificAcademyLikes(userIdx: KeyCenter.userIndex, address: LikeViewController.filterText, delegate: self)
            }else{
                
                dataManager.allAcademyLikes(userIdx: KeyCenter.userIndex, delegate: self)
            }
        }
       
        
        
    }
    override func viewDidLoad() {
        print("academydid")
        super.viewDidLoad()
        emptyViewLabel.text = "로그인후 좋아요 목록을 확인해보세요!"
        emptyView.isHidden = true
        
        self.AcademyCollectionView.dataSource = self
        self.AcademyCollectionView.delegate = self
    }
    
    
}

extension AcademyViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if LikeViewController.isFitered == true{
            if filterdAcademyLikeList.count == 0{
                emptyViewLabel.text = "좋아요한 학원이 없습니다"
                emptyView.isHidden = false
                
                return 0
            }else{
                emptyView.isHidden = true
                emptyViewLabel.text = "로그인후 좋아요 목록을 확인해보세요!"
                return filterdAcademyLikeList.count
            }
            
        }else{
            if academyLikeList.count == 0 && KeyCenter.userType != ""{
                emptyViewLabel.text = "좋아요한 학원이 없습니다"
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
                return academyLikeList.count
            }
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AcademyCollectionViewCell", for: indexPath) as! AcademyCollectionViewCell
        cell.layer.cornerRadius = 6
        
        if LikeViewController.isFitered == true{
            if let url = URL(string: filterdAcademyLikeList[indexPath.row].academyBackImgUrl ?? "") {
                cell.academyImageView.kf.setImage(with: url)
            } else {
                cell.academyImageView.image = UIImage(named: "defaultImage")
            }
            
            cell.academyNameLabel.text = filterdAcademyLikeList[indexPath.row].academyName
            
        }else{
            if let url = URL(string: academyLikeList[indexPath.row].academyBackImgUrl ?? "") {
                cell.academyImageView.kf.setImage(with: url)
            } else {
                cell.academyImageView.image = UIImage(named: "defaultImage")
            }
            
            cell.academyNameLabel.text = academyLikeList[indexPath.row].academyName
           
        }
        
        cell.likeButton.isSelected = true
       
        let image = UIImage(#imageLiteral(resourceName: "heart_fill")).withRenderingMode(.alwaysTemplate)
        cell.likeButton.setImage(image, for: .selected)
        cell.likeButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)


      
        
        
        return cell
    }
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let homeStoryBoard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
        let detailVC = homeStoryBoard.instantiateViewController(withIdentifier: "AcademyDetaliViewController")as!AcademyDetaliViewController
        
        if LikeViewController.isFitered == true{
            detailVC.AcademyInfo = detailAcademyInfo(academyIdx: filterdAcademyLikeList[indexPath.row].academyIdx, academyImage: filterdAcademyLikeList[indexPath.row].academyBackImgUrl, academyName: filterdAcademyLikeList[indexPath.row].academyName, academyPhoneNum: filterdAcademyLikeList[indexPath.row].academyPhone, academyAddress: filterdAcademyLikeList[indexPath.row].academyDetailAddress + " " + (filterdAcademyLikeList[indexPath.row].academyBuilding ?? ""))
        }else{
            
            detailVC.AcademyInfo = detailAcademyInfo(academyIdx: academyLikeList[indexPath.row].academyLikeAcademyIdx, academyImage: academyLikeList[indexPath.row].academyBackImgUrl, academyName: academyLikeList[indexPath.row].academyName, academyPhoneNum: academyLikeList[indexPath.row].academyPhone, academyAddress: academyLikeList[indexPath.row].academyDetailAddress + " " + (academyLikeList[indexPath.row].academyBuilding ?? ""))
        }
        
        
        self.navigationController?.pushViewController(detailVC, animated: true)
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
        if result.isSuccess{
            academyLikeList = result.result ?? []
            print(academyLikeList)
            AcademyCollectionView.reloadData()
        }else{
            presentAlert(title: result.message)
        }
        
    }
    
    func specificAcademyLikes(result : specificaAcademyLikesResponse){
        if result.isSuccess{
            filterdAcademyLikeList = result.result ?? []
            print(filterdAcademyLikeList)
            AcademyCollectionView.reloadData()
        }else{
            presentAlert(title: result.message)
        }
        
    }
    
    func dislikesForAcademy(result :dislikeResponse){
        if result.isSuccess{
            if LikeViewController.isFitered == true{
                
            }else{
               
            }
        }else{
            presentAlert(title: result.message)
        }
        
    }
    
    
    
    func failedToRequest(){
        
        self.presentAlert(title: "서버와의 연결이 원활하지 않습니다")
    
    }
    
}

