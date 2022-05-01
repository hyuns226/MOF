//
//  DetailSearchViewController.swift
//  MOF
//
//  Created by 이현서 on 2021/10/27.
//


import UIKit
class DetailSearchViewController : UIViewController{
    
    static var isFiltered = false
    static var filterRegion = ""
    lazy var dataManager = HomeDataManager()
    var nowTab = 0
    
    static var searchWord  = ""
    lazy var searchBar = UISearchBar()
    var pageViewController : DetailSearchPageViewController!
    
    @IBOutlet weak var AllTabButton: UIButton!
    @IBOutlet weak var KpopTabButton: UIButton!
    @IBOutlet weak var CoreoTabButton: UIButton!
    @IBOutlet weak var HiphopTabButton: UIButton!
    @IBOutlet weak var GirlsHiphopTabButton: UIButton!
    @IBOutlet weak var WaackingTabButton: UIButton!
    @IBOutlet weak var PopinTabButton: UIButton!
    @IBOutlet weak var RockingTabButton: UIButton!
    @IBOutlet weak var CrumpTabButton: UIButton!
    @IBOutlet weak var VoguingTabButton: UIButton!
    @IBOutlet weak var HouseTabButton: UIButton!
    
   
    var buttonLists : [UIButton] = []
    
    var currentIndex : Int = 0 {
        didSet {
            changeButtonColor()
            
        }
    }

    lazy var filter = UIButton()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        print("detailwillappear")
        navigationController?.setNavigationBarHidden(false, animated: animated)
        
       //네비게이션바 라인 제거
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = .white
            appearance.shadowColor = .white
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        }
        
        //change status bar color to light
        UIApplication.shared.statusBarStyle = .darkContent
        
        //하단 탭바 라인 투명하게
       
        self.tabBarController?.tabBar.clipsToBounds = true
       
    
        }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        print("detailloaded")
        
        
        DetailSearchViewController.isFiltered = false
        DetailSearchViewController.filterRegion = ""
        DetailSearchViewController.searchWord  = ""
        
        setButtonList()
        dismissKeyboardInSearchVC()
        
        //검생창 추가
        var bounds = UIScreen.main.bounds
        var width = bounds.size.width //화면 너비
        searchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: width-100, height: 0))
        searchBar.placeholder = "검색어를 입력하세요"
        
        //filter버튼 추가
        filter = UIButton(type: .system)
        filter.frame = CGRect(x: width-100, y: 0, width: 16, height: 16)
        filter.setImage(UIImage(named: "filter"), for: .normal)
        filter.tintColor = .label
        filter.addTarget(self, action: #selector(filterButtonAction), for: .touchUpInside)
        let filterButton = UIBarButtonItem(customView: filter)
        self.navigationItem.rightBarButtonItems = [filterButton,UIBarButtonItem(customView: searchBar)]
        
        filter.isHidden = true
        searchBar.delegate = self
    
        
    }
    
    @objc func filterButtonAction(sender : UIButton){
        let filterVC = self.storyboard?.instantiateViewController(withIdentifier: "SelectRegionViewController")as!SelectRegionViewController
        filterVC.modalPresentationStyle = .fullScreen
        present(filterVC, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(false)
        
        //네비게이션바 라인 원래대로
        if #available(iOS 15.0, *) {
            let appearance = UINavigationBarAppearance()
            appearance.backgroundColor = .white
            appearance.shadowColor = .lightGray
            navigationController?.navigationBar.standardAppearance = appearance
            navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        }
    }
    
    
    //MARK:- Function
    func setButtonList() {
        buttonLists.append(AllTabButton)
        buttonLists.append(KpopTabButton)
        buttonLists.append(CoreoTabButton)
        buttonLists.append(HiphopTabButton)
        buttonLists.append(GirlsHiphopTabButton)
        buttonLists.append(WaackingTabButton)
        buttonLists.append(PopinTabButton)
        buttonLists.append(RockingTabButton)
        buttonLists.append(CrumpTabButton)
        buttonLists.append(VoguingTabButton)
        buttonLists.append(HouseTabButton)
        
        AllTabButton.tintColor = #colorLiteral(red: 0.9671199918, green: 0.2031135857, blue: 0.7404999137, alpha: 1)
        KpopTabButton.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
        CoreoTabButton.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
        HiphopTabButton.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
        GirlsHiphopTabButton.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
        WaackingTabButton.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
        PopinTabButton.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
        RockingTabButton.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
        PopinTabButton.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
        RockingTabButton.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
        CrumpTabButton.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
        VoguingTabButton.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
        HouseTabButton.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
     
    }
    
    func dismissKeyboardInSearchVC() {
        let tap: UITapGestureRecognizer =
            UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
               tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
    }
    
    @objc override func dismissKeyboard() {
        searchBar.resignFirstResponder()
    }
    
    func changeButtonColor() {
        for (index, element) in buttonLists.enumerated() {
            if index == currentIndex {
                element.tintColor = #colorLiteral(red: 0.9671199918, green: 0.2031135857, blue: 0.7404999137, alpha: 1)
            }
            else {
                element.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "DetailSearchPageViewController" {
            guard let vc = segue.destination as? DetailSearchPageViewController else {return}
            pageViewController = vc
            
            pageViewController.completeHandler = { (result) in
                self.currentIndex = result
            }
        }
    }
    
    @IBAction func AllTabAction(_ sender: Any) {
        print("all")
        nowTab = 0
        pageViewController.setViewcontrollersFromIndex(index: 0)
    }
    
        @IBAction func KpopTabAction(_ sender: Any) {
        print("kpop")
        nowTab = 1
        pageViewController.setViewcontrollersFromIndex(index: 1)
        
    }
    @IBAction func CoreoTabAction(_ sender: Any) {
        nowTab = 2
        pageViewController.setViewcontrollersFromIndex(index: 2)
       
    }
    @IBAction func HiphopTabAction(_ sender: Any) {
        print("hiphop")
        nowTab = 3
        pageViewController.setViewcontrollersFromIndex(index: 3)
       
    }

    @IBAction func GirlsHiphopTabAction(_ sender: Any) {
        print("girlshiphop")
        nowTab = 4
        pageViewController.setViewcontrollersFromIndex(index: 4)
        
    }
    @IBAction func WaakingTabAction(_ sender: Any) {
        print("waaking")
        nowTab = 5
        pageViewController.setViewcontrollersFromIndex(index: 5)
       
    }
  
    @IBAction func PopinTabAction(_ sender: Any) {
        print("popin")
        nowTab = 6
        pageViewController.setViewcontrollersFromIndex(index: 6)
        
    }
    
    @IBAction func RockingTabAction(_ sender: Any) {
        print("rocking")
        nowTab = 7
        pageViewController.setViewcontrollersFromIndex(index: 7)
       
    }
    
    @IBAction func CrumpTabAction(_ sender: Any) {
        print("crump")
        nowTab = 8
        pageViewController.setViewcontrollersFromIndex(index: 8)
        
    }
    
    @IBAction func VoguingTabAction(_ sender: Any) {
        print("voguing")
        nowTab = 9
        pageViewController.setViewcontrollersFromIndex(index: 9)
        
    }
    @IBAction func HouseTabAction(_ sender: Any) {
        print("house")
        nowTab = 10
        pageViewController.setViewcontrollersFromIndex(index: 10)
        
    }
    
}

extension DetailSearchViewController : UISearchBarDelegate{
    private func dissmissKeyboard() {
            searchBar.resignFirstResponder()
        }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        // 검색 시작
                
                
                //키보드가 올라와 있을떄, 내려가게
                dissmissKeyboard()
                
                // 검색어가 있는지
            DetailSearchViewController.searchWord = searchBar.text ?? ""
        print("검색어: \(DetailSearchViewController.searchWord)")
        filter.isHidden = false
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "\(nowTab)"), object: nil)
        
       
                
        }
    
    

    
    
    
}

