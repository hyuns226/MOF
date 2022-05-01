//
//  SelectRegionViewController.swift
//  MOF
//
//  Created by 이현서 on 2021/11/11.
//

import UIKit
class SelectRegionViewController : UIViewController, UIGestureRecognizerDelegate,RegionCellDelegate {
    
    var clickList : [Int] = []
    @IBOutlet weak var regionTableView: UITableView!
    
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!

 
    @IBOutlet weak var resetButton: UIButton!

    

    var nowTag : Int = 1
    var nowText : String = ""
    var nowID : Int = 0
    var regionList : Array<String> = []
    var tagList = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17]
    let cityList = regionData.cityList
    
    
    var seoulClickedList = Array<Int>(repeating: 0, count: regionData.seoulList.count)
    var busanClickedList = Array<Int>(repeating: 0, count: regionData.busanList.count)
    var deaguClickedList = Array<Int>(repeating: 0, count: regionData.deaguList.count)
    var incheonClickedList = Array<Int>(repeating: 0, count: regionData.incheonList.count)
    var gwangjuClickedList = Array<Int>(repeating: 0, count: regionData.gwangjuList.count)
    var daejeonClickedList = Array<Int>(repeating: 0, count: regionData.daejeonList.count)
    var ulsanClickedList = Array<Int>(repeating: 0, count: regionData.ulsanList.count)
    var sejongClickedList = Array<Int>(repeating: 0, count: regionData.sejongList.count)
    var gyeongiClickedList = Array<Int>(repeating: 0, count: regionData.gyeonggiList.count)
    var gyeongnamClickedList = Array<Int>(repeating: 0, count: regionData.gyeongnamList.count)
    var gyeongbukClickedList = Array<Int>(repeating: 0, count: regionData.gyeonbukList.count)
    var chungnamClickedList = Array<Int>(repeating: 0, count: regionData.chungnamList.count)
    var chungbukClickedList = Array<Int>(repeating: 0, count: regionData.chungbukList.count)
    var jeonnamClickedList = Array<Int>(repeating: 0, count: regionData.jeonnamList.count)
    var jeonbukClickedList = Array<Int>(repeating: 0, count: regionData.jeonbukList.count)
    var gangwonClickedList = Array<Int>(repeating: 0, count: regionData.gangwonList.count)
    var jejuClickedList = Array<Int>(repeating: 0, count: regionData.jejuList.count)
    
    
    
    lazy var ClickedList = [seoulClickedList,busanClickedList,deaguClickedList,incheonClickedList,gwangjuClickedList,daejeonClickedList,ulsanClickedList,sejongClickedList,gyeongiClickedList,gyeongnamClickedList,gyeongbukClickedList,chungnamClickedList,chungbukClickedList,jeonnamClickedList,jeonbukClickedList,gangwonClickedList,jejuClickedList]
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        resetButton.setTitleColor(.mainPink, for: .normal)
        
        regionTableView.dataSource = self
     
        
        self.regionTableView.rowHeight = viewHeight.constant/17;
        regionList = regionData.seoulList
        
        clickList = Array<Int>(repeating: 0, count: regionList.count)
        nowTag = 1
        
        //네비게이션 바 라인 없애기
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    
    @IBAction func closeButtonAction(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    @IBAction func resetButtonAction(_ sender: Any) {
        reset()
        //reload
        nowText = ""
        regionTableView.reloadData()
        
    }
    
    func setRegionList(nowTag : Int, sender : UIButton){
        self.nowTag = nowTag
        regionList = regionData.allRegionData[nowTag - 1]
        setFontnBackground(sender: sender)
        clickList = ClickedList[nowTag - 1]
    }
    
    
    @IBAction func regionButtonClicked(_ sender: UIButton) {
        switch sender.tag{
        case 1 :
            setRegionList(nowTag: sender.tag, sender : sender)
            
            break
        case 2 :
            setRegionList(nowTag: sender.tag, sender : sender)
            break
         
        case 3 :
            setRegionList(nowTag: sender.tag, sender : sender)
            break
        case 4 :
            setRegionList(nowTag: sender.tag, sender : sender)
            break
        case 5 :
            setRegionList(nowTag: sender.tag, sender : sender)
            break
        case 6 :
            setRegionList(nowTag: sender.tag, sender : sender)
            break
        case 7 :
            setRegionList(nowTag: sender.tag, sender : sender)
            break
        case 8 :
            setRegionList(nowTag: sender.tag, sender : sender)
            break
        case 9 :
            setRegionList(nowTag: sender.tag, sender : sender)
            break
        case 10:
            setRegionList(nowTag: sender.tag, sender : sender)
            break
        case 11:
            setRegionList(nowTag: sender.tag, sender : sender)
            break
        case 12:
            setRegionList(nowTag: sender.tag, sender : sender)
            break
        case 13:
            setRegionList(nowTag: sender.tag, sender : sender)
            break
        case 14:
            setRegionList(nowTag: sender.tag, sender : sender)
            break
        case 15:
            setRegionList(nowTag: sender.tag, sender : sender)
            break
        case 16:
            setRegionList(nowTag: sender.tag, sender : sender)
            break
        case 17:
            setRegionList(nowTag: sender.tag, sender : sender)
            break
    
        default:
            print("")
        }
        
    }
    
    func setFontnBackground(sender : UIButton){
        //눌러진 버튼 세팅
        let sender = sender
        self.regionTableView.reloadData()
        sender.titleLabel?.font = UIFont(name: "NotoSansCJKkr-Bold", size: 14)
        sender.setTitleColor(#colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1), for: .normal)
        sender.backgroundColor = .white
        
        //눌러진 버튼 이외 버튼 세팅
        print(sender.tag)
        tagList.remove(at: sender.tag-1)
        print(tagList)
        for i in tagList{
            print(i)
            let tmpButton = self.view.viewWithTag(i) as? UIButton
            print(tmpButton)
            tmpButton?.titleLabel?.font = UIFont(name: "NotoSansCJKkr-Bold", size: 14)
            tmpButton!.setTitleColor(#colorLiteral(red: 0.6980392157, green: 0.6980392157, blue: 0.6980392157, alpha: 1), for: .normal)
            tmpButton?.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
            
        }
        tagList.append(sender.tag)
        tagList.sort()
        print(tagList)
        
        
    }
    
    func reset(){
        
        for i in 0...ClickedList.count-1{
            ClickedList[i] = Array<Int>(repeating: 0, count: regionData.allRegionData[i].count)
        }
       
        
    }
    
    
    @IBAction func selectButtonAction(_ sender: Any) {
        
        print(nowText)
        if nowText == ""{
            DetailSearchViewController.isFiltered = false
            DetailSearchViewController.filterRegion = ""
        }else{
            DetailSearchViewController.isFiltered = true
            DetailSearchViewController.filterRegion = nowText
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
}

extension SelectRegionViewController : UITableViewDataSource,GeneralRegionCellDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return regionList.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RegionTableViewCell") as! RegionTableViewCell
        
        cell.delegate = self
        cell.index = indexPath.row
        
        let background = UIView()

        background.backgroundColor = .clear

        cell.selectedBackgroundView = background
        
        cell.regionButton.setTitle(regionList[indexPath.row], for: .normal)
        
        print("nowTag \(nowTag)")

        
        func setIsTouched(tag : Int, index : Int){
                if ClickedList[tag-1][index] == 1 {
                    cell.isTouched = true
                }else{
                    cell.isTouched = false
                }
        }

        switch nowTag{
        case 1 :
            setIsTouched(tag : nowTag, index : indexPath.row)
           break
        case 2:
            setIsTouched(tag : nowTag, index : indexPath.row)
            break
        case 3:
            setIsTouched(tag : nowTag, index : indexPath.row)
            break
        case 4:
            setIsTouched(tag : nowTag, index : indexPath.row)
            break
        case 5:
            setIsTouched(tag : nowTag, index : indexPath.row)
            break
        case 6:
            setIsTouched(tag : nowTag, index : indexPath.row)
            break
        case 7:
            setIsTouched(tag : nowTag, index : indexPath.row)
            break
        case 8:
            setIsTouched(tag : nowTag, index : indexPath.row)
            break
        case 9:
            setIsTouched(tag : nowTag, index : indexPath.row)
            break
        case 10:
            setIsTouched(tag : nowTag, index : indexPath.row)
            break
        case 11:
            setIsTouched(tag : nowTag, index : indexPath.row)
            break
        case 12:
            setIsTouched(tag : nowTag, index : indexPath.row)
            break
        case 13:
            setIsTouched(tag : nowTag, index : indexPath.row)
            break
        case 14:
            setIsTouched(tag : nowTag, index : indexPath.row)
            break
        case 15:
            setIsTouched(tag : nowTag, index : indexPath.row)
            break
        case 16:
            setIsTouched(tag : nowTag, index : indexPath.row)
            break
        case 17:
            setIsTouched(tag : nowTag, index : indexPath.row)
            break
        default:
            print("")
        }
        
        
              
        return cell
    }

    
    
    func setButtonAndData(tag : Int, index : Int ){
            reset()
            
            ClickedList[nowTag-1][index] = 1
            print("클림됨? \(ClickedList[nowTag-1])")
            //nowID = index+1
            nowText = cityList[nowTag-1]+regionData.allRegionData[nowTag-1][index]
            regionTableView.reloadData()
            
        }
        
        
    func didPressButton(for index: Int, clicked: Bool) {
            if clicked == true{
                switch nowTag{
                case 1 :
                    print("작동함?")
                    setButtonAndData(tag : nowTag, index : index)
                case 2 :
                    print("작동함?")
                    setButtonAndData(tag : nowTag, index : index)
                case 3 :
                    setButtonAndData(tag : nowTag, index : index)
                case 4 :
                    setButtonAndData(tag : nowTag, index : index)
                case 5 :
                    setButtonAndData(tag : nowTag, index : index)
                case 6 :
                    setButtonAndData(tag : nowTag, index : index)
                case 7 :
                    setButtonAndData(tag : nowTag, index : index)
                case 8 :
                    setButtonAndData(tag : nowTag, index : index)
                case 9 :
                    setButtonAndData(tag : nowTag, index : index)
                case 10 :
                    setButtonAndData(tag : nowTag, index : index)
                case 11:
                    setButtonAndData(tag : nowTag, index : index)
                case 12:
                    setButtonAndData(tag : nowTag, index : index)
                case 13:
                    setButtonAndData(tag : nowTag, index : index)
                case 14:
                    setButtonAndData(tag : nowTag, index : index)
                case 15:
                    setButtonAndData(tag : nowTag, index : index)
                case 16:
                    setButtonAndData(tag : nowTag, index : index)
                case 17:
                    setButtonAndData(tag : nowTag, index : index)
                default :
                    print("default")
                
                }
            
              
                
                print (seoulClickedList)
                print(busanClickedList)
            
               
            }
        }
}


