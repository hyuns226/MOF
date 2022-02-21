//
//  HomePageViewController.swift
//  MOF
//
//  Created by 이현서 on 2021/10/26.
//

import UIKit

class HomePageViewController: UIPageViewController {

    var completeHandler : ((Int)->())?
        
        let viewList : [UIViewController] = {
            
            let storyBoard = UIStoryboard(name: "HomeStoryboard", bundle: nil)
            let vc0 = storyBoard.instantiateViewController(identifier: "AllViewController")
            let vc1 = storyBoard.instantiateViewController(identifier: "KpopViewController")
            let vc2 = storyBoard.instantiateViewController(identifier: "CoreoViewController")
            let vc3 = storyBoard.instantiateViewController(identifier: "HiphopViewController")
            let vc4 = storyBoard.instantiateViewController(identifier: "GirsHiphopViewController")
            let vc5 = storyBoard.instantiateViewController(identifier: "WaakingViewController")
            let vc6 = storyBoard.instantiateViewController(identifier: "PopinViewController")
            let vc7 = storyBoard.instantiateViewController(identifier: "RockingViewController")
            let vc8 = storyBoard.instantiateViewController(identifier: "CrumpViewController")
            let vc9 = storyBoard.instantiateViewController(identifier: "VoguingViewController")
            let vc10 = storyBoard.instantiateViewController(identifier: "HouseViewController")
          
            
            return [vc0, vc1, vc2, vc3, vc4, vc5, vc6, vc7, vc8, vc9, vc10]
            
        } ()
        
        var currentIndex : Int {
                guard let vc = viewControllers?.first else { return 0 }
                return viewList.firstIndex(of: vc) ?? 0
            }

        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.dataSource = self
            self.delegate = self
            
            if let firstVC = viewList.first{
                self.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
            }

        }
        
        // 버튼으로 화면 전환
        func setViewcontrollersFromIndex(index : Int){
                 if index < 0 && index >= viewList.count {return }
            self.setViewControllers([viewList[index]], direction: .forward, animated: true, completion: nil)
            print(currentIndex)
               completeHandler?(currentIndex)
        }
        
        // 현재 뷰 위치
        func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
               if completed {
                   
                   completeHandler?(currentIndex)
               }
        }
        
        // 페이지 전환 방식
        required init?(coder aDecoder: NSCoder) {
            super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        }
        

    }

    extension HomePageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
            
            guard let index = viewList.firstIndex(of: viewController) else {return nil}
            let previousIndex = index - 1
            if previousIndex < 0 { return nil}
            return viewList[previousIndex]
        }
        
        func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
            
            guard let index = viewList.firstIndex(of: viewController) else {return nil}
             let nextIndex = index + 1
             if nextIndex == viewList.count { return nil}
             return viewList[nextIndex]
        }
        
        
        
        
    }

