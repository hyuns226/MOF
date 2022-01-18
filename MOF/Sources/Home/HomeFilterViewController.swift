//
//  HomeFilterViewController.swift
//  MOF
//
//  Created by 이현서 on 2022/01/05.
//

import UIKit
class HomeFilterViewController : UIViewController, UIGestureRecognizerDelegate {
    
    //weak var delegate: regionDelegate?
    
    var clickList : [Int] = []
    @IBOutlet weak var regionTableView: UITableView!
    
    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var viewHeight: NSLayoutConstraint!

    @IBOutlet weak var resetButton: UIButton!
    @IBOutlet weak var regionSelectItem: UIBarButtonItem!
    
    var nowTag : Int = 0
    var nowText : String = ""
    var nowID : Int = 0
    var region : regionData?
    var regionList : Array<String> = []
    var tagList = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17]
   
    var seoulClickedList = Array<Int>(repeating: 0, count: regionData.seoulList.count)
    var busanClickedList = Array<Int>(repeating: 0, count: regionData.busanList.count)
    var jejuClickedList = Array<Int>(repeating: 0, count: regionData.jejuList.count)
    var gangwonClickedList = Array<Int>(repeating: 0, count: regionData.gangwonList.count)
    var gyeongiClickedList = Array<Int>(repeating: 0, count: regionData.gyeonggiList.count)
    var incheonClickedList = Array<Int>(repeating: 0, count: regionData.incheonList.count)
    var deaguClickedList = Array<Int>(repeating: 0, count: regionData.deaguList.count)
    var ulsanClickedList = Array<Int>(repeating: 0, count: regionData.ulsanList.count)
    var gyeongnamClickedList = Array<Int>(repeating: 0, count: regionData.gyeongnamList.count)
    var gyeongbukClickedList = Array<Int>(repeating: 0, count: regionData.gyeonbukList.count)
    var gwangjuClickedList = Array<Int>(repeating: 0, count: regionData.gwangjuList.count)
    var jeonnamClickedList = Array<Int>(repeating: 0, count: regionData.jeonnamList.count)
    var jeonbukClickedList = Array<Int>(repeating: 0, count: regionData.jeonbukList.count)
    var daejeonClickedList = Array<Int>(repeating: 0, count: regionData.daejeonList.count)
    var chungnamClickedList = Array<Int>(repeating: 0, count: regionData.chungnamList.count)
    var chungbukClickedList = Array<Int>(repeating: 0, count: regionData.chungbukList.count)
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(false)
        
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        resetButton.isEnabled = false
        selectButton.isEnabled = false
        
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
        resetButton.tintColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
        resetButton.isEnabled = false
        selectButton.backgroundColor = #colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1)
        selectButton.isEnabled = false
        regionTableView.reloadData()
        //UploadAirbnbSecondStepViewController.airbnbInput.locationId = 0
    }
    
    
    
    @IBAction func regionButtonClicked(_ sender: UIButton) {
        switch sender.tag{
        case 1 :
            nowTag = sender.tag
            regionList = regionData.seoulList
            setFontnBackground(sender: sender)
            clickList = seoulClickedList
            break
        case 2 :
            nowTag = sender.tag
            regionList = regionData.busanList
            setFontnBackground(sender: sender)
            clickList = busanClickedList
            break
         
        case 3 :
            nowTag = sender.tag
            regionList = regionData.jejuList
            setFontnBackground(sender: sender)
            clickList = gangwonClickedList
            break
        case 4 :
            nowTag = sender.tag
            regionList = regionData.gangwonList
            setFontnBackground(sender: sender)
            clickList = gyeongiClickedList
            break
        case 5 :
            nowTag = sender.tag
            regionList = regionData.gyeonggiList
            setFontnBackground(sender: sender)
            clickList = incheonClickedList
            break
        case 6 :
            nowTag = sender.tag
            regionList = regionData.incheonList
            setFontnBackground(sender: sender)
            clickList = deaguClickedList
            break
        case 7 :
            nowTag = sender.tag
            regionList = regionData.deaguList
            setFontnBackground(sender: sender)
            clickList = incheonClickedList
            break
        case 8 :
            nowTag = sender.tag
            regionList = regionData.ulsanList
            setFontnBackground(sender: sender)
            clickList = ulsanClickedList
            break
        case 9 :
            nowTag = sender.tag
            regionList = regionData.gyeongnamList
            setFontnBackground(sender: sender)
            clickList = gyeongnamClickedList
            break
        case 10:
            nowTag = sender.tag
            regionList = regionData.gyeonbukList
            setFontnBackground(sender: sender)
            clickList = gyeongbukClickedList
            break
        case 11:
            nowTag = sender.tag
            regionList = regionData.gwangjuList
            setFontnBackground(sender: sender)
            clickList = gwangjuClickedList
            break
        case 12:
            nowTag = sender.tag
            regionList = regionData.jeonnamList
            setFontnBackground(sender: sender)
            clickList = jeonnamClickedList
            
            break
        case 13:
            nowTag = sender.tag
            regionList = regionData.jeonbukList
            setFontnBackground(sender: sender)
            clickList = jeonbukClickedList
            break
        case 14:
            nowTag = sender.tag
            regionList = regionData.daejeonList
            setFontnBackground(sender: sender)
            clickList = daejeonClickedList
            break
        case 15:
            nowTag = sender.tag
            regionList = regionData.chungnamList
            setFontnBackground(sender: sender)
            clickList = chungnamClickedList
            break
        case 16:
            nowTag = sender.tag
            regionList = regionData.chungbukList
            setFontnBackground(sender: sender)
            clickList = chungbukClickedList
            break
    
        default:
            print("")
        }
        
    }
    
    func setFontnBackground(sender : UIButton){
        //눌러진 버튼 세팅
        let sender = sender
        self.regionTableView.reloadData()
        sender.titleLabel?.font = UIFont(name: "NotoSansCJKKR-Bold", size: 14)
        sender.setTitleColor(#colorLiteral(red: 0.1333333333, green: 0.1333333333, blue: 0.1333333333, alpha: 1), for: .normal)
        sender.backgroundColor = .white
        
        //눌러진 버튼 이외 버튼 세팅
        tagList.remove(at: sender.tag - 1)
        for i in tagList{
            let tmpButton = self.view.viewWithTag(i) as? UIButton
            tmpButton?.titleLabel?.font = UIFont(name: "Noto Sans CJK KR", size: 14)
            tmpButton!.setTitleColor(#colorLiteral(red: 0.6509803922, green: 0.6901960784, blue: 0.7294117647, alpha: 1), for: .normal)
            tmpButton?.backgroundColor = #colorLiteral(red: 0.9725490196, green: 0.9725490196, blue: 0.9725490196, alpha: 1)
            
        }
        tagList.append(sender.tag)
        tagList.sort()
        print(tagList)
        
        
    }
    
    func reset(){
        seoulClickedList = Array<Int>(repeating: 0, count: regionData.seoulList.count)
         busanClickedList = Array<Int>(repeating: 0, count: regionData.busanList.count)
         jejuClickedList = Array<Int>(repeating: 0, count: regionData.jejuList.count)
         gangwonClickedList = Array<Int>(repeating: 0, count: regionData.gangwonList.count)
         gyeongiClickedList = Array<Int>(repeating: 0, count: regionData.gyeonggiList.count)
         incheonClickedList = Array<Int>(repeating: 0, count: regionData.incheonList.count)
         deaguClickedList = Array<Int>(repeating: 0, count: regionData.deaguList.count)
         ulsanClickedList = Array<Int>(repeating: 0, count: regionData.ulsanList.count)
         gyeongnamClickedList = Array<Int>(repeating: 0, count: regionData.gyeongnamList.count)
         gyeongbukClickedList = Array<Int>(repeating: 0, count: regionData.gyeonbukList.count)
         gwangjuClickedList = Array<Int>(repeating: 0, count: regionData.gwangjuList.count)
         jeonnamClickedList = Array<Int>(repeating: 0, count: regionData.jeonnamList.count)
         jeonbukClickedList = Array<Int>(repeating: 0, count: regionData.jeonbukList.count)
         daejeonClickedList = Array<Int>(repeating: 0, count: regionData.daejeonList.count)
         chungnamClickedList = Array<Int>(repeating: 0, count: regionData.chungnamList.count)
         chungbukClickedList = Array<Int>(repeating: 0, count: regionData.chungbukList.count)
        
    }
    
    
    @IBAction func selectButtonAction(_ sender: Any) {
        
       // delegate?.sendregionName(forShow: nowText)
       // UploadAirbnbSecondStepViewController.airbnbInput.locationId = nowID
        print(nowText)
        self.dismiss(animated: true, completion: nil)
        
        
    }
    
}

extension HomeFilterViewController : UITableViewDataSource,RegionCellDelegate{
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
        
        switch nowTag{
        case 1 :
            if seoulClickedList[indexPath.row] == 1 {
                        cell.isTouched = true
                    }else{
                        cell.isTouched = false
                    }
           break
        case 2:
            if busanClickedList[indexPath.row] == 1 {
                        cell.isTouched = true
                    }else{
                        cell.isTouched = false}
            break
        case 3:
            if jejuClickedList[indexPath.row] == 1 {
                        cell.isTouched = true
                    }else{
                        cell.isTouched = false}
            break
        case 4:
            if gangwonClickedList[indexPath.row] == 1 {
                        cell.isTouched = true
                    }else{
                        cell.isTouched = false}
            break
        case 5:
            if gyeongiClickedList[indexPath.row] == 1 {
                        cell.isTouched = true
                    }else{
                        cell.isTouched = false}
            break
        case 6:
            if incheonClickedList[indexPath.row] == 1 {
                        cell.isTouched = true
                    }else{
                        cell.isTouched = false}
            break
        case 7:
            if deaguClickedList[indexPath.row] == 1 {
                        cell.isTouched = true
                    }else{
                        cell.isTouched = false}
            break
        case 8:
            if ulsanClickedList[indexPath.row] == 1 {
                        cell.isTouched = true
                    }else{
                        cell.isTouched = false}
            break
        case 9:
            if gyeongnamClickedList[indexPath.row] == 1 {
                        cell.isTouched = true
                    }else{
                        cell.isTouched = false}
            break
        case 10:
            if gyeongbukClickedList[indexPath.row] == 1 {
                        cell.isTouched = true
                    }else{
                        cell.isTouched = false}
            break
        case 11:
            if gwangjuClickedList[indexPath.row] == 1 {
                        cell.isTouched = true
                    }else{
                        cell.isTouched = false}
            break
        case 12:
            if jeonnamClickedList[indexPath.row] == 1 {
                        cell.isTouched = true
                    }else{
                        cell.isTouched = false}
            break
        case 13:
            if jeonbukClickedList[indexPath.row] == 1 {
                        cell.isTouched = true
                    }else{
                        cell.isTouched = false}
            break
        case 14:
            if daejeonClickedList[indexPath.row] == 1 {
                        cell.isTouched = true
                    }else{
                        cell.isTouched = false}
            break
        case 15:
            if chungnamClickedList[indexPath.row] == 1 {
                        cell.isTouched = true
                    }else{
                        cell.isTouched = false}
            break
        case 16:
            if chungbukClickedList[indexPath.row] == 1 {
                        cell.isTouched = true
                    }else{
                        cell.isTouched = false}
            break
        default:
            print("")
        }
        
              
        return cell
    }
    
    func didPressButton(for index: Int, clicked: Bool) {
            if clicked == true{
                if nowTag == 1{
                    reset()
                    seoulClickedList[index] = 1
                    nowID = index+1
                    nowText = regionData.seoulList[index]
                    regionTableView.reloadData()
                    
                }else if nowTag == 2{
                    reset()
                    busanClickedList[index] = 1
                    regionTableView.reloadData()
                    nowText = regionData.busanList[index]
                    nowID = index+1+22
                    
                }else if nowTag == 3{
                    reset()
                   jejuClickedList[index] = 1
                    nowText = regionData.jejuList[index]
                    nowID = index+1+37
                    regionTableView.reloadData()
                    
                }else if nowTag == 4{
                    reset()
                    gangwonClickedList[index] = 1
                    nowText = regionData.gangwonList[index]
                    nowID = index+1+44
                    regionTableView.reloadData()
                }else if nowTag == 5{
                    reset()
                    gyeongiClickedList[index] = 1
                    nowText = regionData.gyeonggiList[index]
                    nowID = index+1+55
                    regionTableView.reloadData()
                }else if nowTag == 6{
                    reset()
                    incheonClickedList[index] = 1
                    nowText = regionData.incheonList[index]
                    nowID = index+1+77
                    regionTableView.reloadData()
                }else if nowTag == 7{
                    reset()
                    deaguClickedList[index] = 1
                    nowText = regionData.deaguList[index]
                    nowID = index+1+88
                    regionTableView.reloadData()
                }else if nowTag == 8{
                    reset()
                    ulsanClickedList[index] = 1
                    nowText = regionData.ulsanList[index]
                    nowID = index+1+96
                    regionTableView.reloadData()
                }else if nowTag == 9{
                    reset()
                    gyeongnamClickedList[index] = 1
                    nowText = regionData.gyeongnamList[index]
                    nowID = index+1+98
                    regionTableView.reloadData()
                  
                }else if nowTag == 10{
                    reset()
                    gyeongbukClickedList[index] = 1
                    nowText = regionData.gyeonbukList[index]
                    nowID = index+1+110
                    regionTableView.reloadData()
                    
                }else if nowTag == 11{
                    reset()
                    gwangjuClickedList[index] = 1
                    nowText = regionData.gwangjuList[index]
                    nowID = index+1+123
                    regionTableView.reloadData()
                   
                }else if nowTag == 12{
                    reset()
                    jeonnamClickedList[index] = 1
                    nowText = regionData.jeonnamList[index]
                    nowID = index+1+127
                    regionTableView.reloadData()
                    
                }else if nowTag == 13{
                    reset()
                    jeonbukClickedList[index] = 1
                    nowText = regionData.jeonbukList[index]
                    nowID = index+1+140
                    regionTableView.reloadData()
                    
                }else if nowTag == 14{
                    reset()
                    daejeonClickedList[index] = 1
                    nowText = regionData.daejeonList[index]
                    nowID = index+1+148
                    regionTableView.reloadData()
        
                }else if nowTag == 15{
                    reset()
                  chungnamClickedList[index] = 1
                    nowText = regionData.chungnamList[index]
                    nowID = index+1+152
                    regionTableView.reloadData()
                }else if nowTag == 16{
                    reset()
                    chungbukClickedList[index] = 1
                    nowText = regionData.seoulList[index]
                    nowID = index+1+165
                    regionTableView.reloadData()
                }
                //print(UploadAirbnbSecondStepViewController.airbnbInput.locationId)
                
                selectButton.isEnabled = true
                selectButton.backgroundColor = #colorLiteral(red: 0.9671199918, green: 0.2031135857, blue: 0.7404999137, alpha: 1)
                
                resetButton.isEnabled = true
                resetButton.tintColor = #colorLiteral(red: 0.9671199918, green: 0.2031135857, blue: 0.7404999137, alpha: 1)
                
                print (seoulClickedList)
                print(busanClickedList)
            
               
            }
        }
}


