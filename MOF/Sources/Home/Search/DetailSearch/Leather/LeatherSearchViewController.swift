//
//  LeatherSearchViewController.swift
//  MOF
//
//  Created by 이현서 on 2021/10/27.
//

import UIKit
class LeatherSearchViewController : UIViewController{
    @IBOutlet weak var leatherSearchCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        SettingCollectionView()
    }
    
//MARK:- FUNCTION
        
        //collectionview 세팅
        func SettingCollectionView(){
            leatherSearchCollectionView.dataSource = self
            leatherSearchCollectionView.delegate = self
        }
}


//MARK-: EXTENSION

//MARK-: COLLECTIONVIEW
extension LeatherSearchViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LeatherSearchCollectionViewCell", for: indexPath) as! LeatherSearchCollectionViewCell
        cell.layer.cornerRadius = 6
        return cell
    }
    
}

//MARK-: COLLECTIONVIEW FLOWLAYOUT
extension LeatherSearchViewController : UICollectionViewDelegateFlowLayout{
    
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
        
        width = (collectionView.frame.width - 10) / 2 ///  2등분하여 배치, 옆 간격이 10이므로 5을 빼줌
//                    print("collectionView width=\(collectionView.frame.width)")
//                    print("cell하나당 width=\(width)")
//                    print("root view width = \(self.view.frame.width)")
        height = width
        size = CGSize(width: width, height: height)
                
        
        return size
    }
    
    
    
}
