//
//  CustomTabViewController.swift
//  MOF
//
//  Created by 이현서 on 2021/10/26.
//

import UIKit
class HomeViewController : UIViewController{
    
    lazy var dataManager = HomeDataManager()
    
    let genreList = ["K-POP" ,"Choreo" ,"HipHop", "GirlsHipHop" ,"Waacking" ,"Popping", "Locking", "Krump" ,"Voguing", "House"]
    
    var nowGenre = ""
    
    var pageViewController : HomePageViewController!
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        self.navigationController?.navigationBar.isHidden = false
        nowGenre = genreList[0]
         dataManager.specificGenre(genre: genreList[0], delegate: self)
        
        }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        setButtonList()
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
        
        if segue.identifier == "HomePageViewController" {
            guard let vc = segue.destination as? HomePageViewController else {return}
            pageViewController = vc
            
            pageViewController.completeHandler = { (result) in
                self.currentIndex = result
            }
        }
    }
    
    @IBAction func AllTabAction(_ sender: Any) {
        print("all")
        pageViewController.setViewcontrollersFromIndex(index: 0)
    }
    
    @IBAction func KpopTabAction(_ sender: Any) {
        print("kpop")
        pageViewController.setViewcontrollersFromIndex(index: 1)
        
    }
    @IBAction func CoreoTabAction(_ sender: Any) {
        pageViewController.setViewcontrollersFromIndex(index: 2)
       
    }
    @IBAction func HiphopTabAction(_ sender: Any) {
        print("hiphop")
        pageViewController.setViewcontrollersFromIndex(index: 3)
       
    }
    @IBAction func GirlsHiphopTabAction(_ sender: Any) {
        print("girlshiphop")
        pageViewController.setViewcontrollersFromIndex(index: 4)
        
    }
    @IBAction func WaakingTabAction(_ sender: Any) {
        print("waaking")
        pageViewController.setViewcontrollersFromIndex(index: 5)
       
    }
  
    @IBAction func PopinTabAction(_ sender: Any) {
        print("popin")
        pageViewController.setViewcontrollersFromIndex(index: 6)
        
    }
    
    @IBAction func RockingTabAction(_ sender: Any) {
        print("rocking")
        pageViewController.setViewcontrollersFromIndex(index: 7)
       
    }
    
    @IBAction func CrumpTabAction(_ sender: Any) {
        print("crump")
        pageViewController.setViewcontrollersFromIndex(index: 8)
        
    }
    
    @IBAction func VoguingTabAction(_ sender: Any) {
        print("voguing")
        pageViewController.setViewcontrollersFromIndex(index: 9)
        
    }
    @IBAction func HouseTabAction(_ sender: Any) {
        print("house")
        pageViewController.setViewcontrollersFromIndex(index: 10)
        
    }
    
}

//MARK:- API
extension HomeViewController{
    
    func specificGenre(result : specificGenreResponse){
        //print(result)
        switch nowGenre{
        case genreList[0] :
            KpopViewController.kpopResultList = result.result ?? []
            nowGenre = genreList[1]
            dataManager.specificGenre(genre: genreList[1], delegate: self)
            break
        case genreList[1] :
            CoreoViewController.choreoResultList = result.result ?? []
            nowGenre = genreList[2]
            dataManager.specificGenre(genre: genreList[2], delegate: self)
            break
        case genreList[2] :
            HiphopViewController.hiphopResultList = result.result ?? []
            nowGenre = genreList[3]
            dataManager.specificGenre(genre: genreList[3], delegate: self)
            break
        case genreList[3] :
            GirsHiphopViewController.girlsHiphopResultList = result.result
                ?? []
            nowGenre = genreList[4]
            dataManager.specificGenre(genre: genreList[4], delegate: self)
            break
        case genreList[4] :
            WaakingViewController.waakingResultList = result.result ?? []
            nowGenre = genreList[5]
            dataManager.specificGenre(genre: genreList[5], delegate: self)
            break
        case genreList[5] :
            PopinViewController.popinResultList = result.result ?? []
            nowGenre = genreList[6]
            dataManager.specificGenre(genre: genreList[6], delegate: self)
            break
        case genreList[6] :
            RockingViewController.rockingResultList = result.result ?? []
            nowGenre = genreList[7]
            dataManager.specificGenre(genre: genreList[7], delegate: self)
            break
        case genreList[7] :
            CrumpViewController.crumpResultList = result.result ?? []
            nowGenre = genreList[8]
            dataManager.specificGenre(genre: genreList[8], delegate: self)
            break
        case genreList[8] :
            VoguingViewController.voguingResultList = result.result ?? []
            nowGenre = genreList[9]
            dataManager.specificGenre(genre: genreList[9], delegate: self)
            break
        case genreList[9] :
            HouseViewController.houseResultList = result.result ?? []
            break
        default:
            print("default")
        }
        
        
       
        
        
    }
    
    func allGenreSpecificLocation(result : specificGenreResponse){
        KpopViewController.kpopResultList = result.result ?? []
        
        
    }
    
    func failedToRequest(){
        
        self.presentAlert(title: "서버와의 연결이 원활하지 않습니다")
    
    }
    
}
