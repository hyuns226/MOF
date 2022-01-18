//
//  LikeViewController.swift
//  MOF
//
//  Created by 이현서 on 2021/12/02.
//

import UIKit
class AcademyViewController : UIViewController {
    
    
    @IBOutlet weak var AcademyCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.AcademyCollectionView.dataSource = self
        self.AcademyCollectionView.delegate = self
    }
    
    
}

extension AcademyViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AcademyCollectionViewCell", for: indexPath) as! AcademyCollectionViewCell
        cell.layer.cornerRadius = 6
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
        
        width = (collectionView.frame.width - 10) / 2 ///  2등분하여 배치, 옆 간격이 10이므로 5을 빼줌
//                    print("collectionView width=\(collectionView.frame.width)")
//                    print("cell하나당 width=\(width)")
//                    print("root view width = \(self.view.frame.width)")
        height = width
        size = CGSize(width: width, height: height)
                
        
        return size
    }
    
}

