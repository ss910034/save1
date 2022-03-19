//
//  DialogViewController.swift
//  HereHearV2
//
//  Created by Frank Liu on 2019/6/24.
//  Copyright © 2019 Frank Liu. All rights reserved.
//

import UIKit
import SwiftyJSON

class invoiceDialogViewController: InfoDialogViewController {

    @IBOutlet weak var hero: UIImageView!
    @IBOutlet weak var date: UIImageView!
    @IBOutlet weak var count1: UILabel!
    @IBOutlet weak var count2: UILabel!
    @IBOutlet weak var count3: UILabel!
    @IBOutlet weak var count21: UILabel!
    @IBOutlet weak var count22: UILabel!
    @IBOutlet weak var count23: UILabel!
    @IBOutlet weak var count31: UILabel!
    @IBOutlet weak var count32: UILabel!
    @IBOutlet weak var count33: UILabel!

    var selectedIndex = 0
    var incCount = 0
    var incBingo = 0
    var incPrice = 0
    
    var voiceDic:[String : String] = ["1" : "3/25",
                                      "2" : "5/25",
                                      "3" : "7/25",
                                      "4" : "9/25",
                                      "5" : "11/25",
                                      "6" : "1/25"]
    
    var currMoth = ""
    var alreadyOpen = false
    
    override func viewDidLoad() {
        // super.viewDidLoad()
        self.view.isOpaque = false
        hero.image = UIImage(named: String(format: "h%d%d", gHereIndex, gHereIndex))
        date.image = UIImage(named: String(format: "month%d", selectedIndex+1))
        currMoth = String(format: "month%d", selectedIndex+1)
        
        var count = 0
        var bingo = 0
        var bingoMoney = 0
        var status = "0"
        
        let m:Int = Constants.getDateComps(date: Date()).month!
        let d:Int = Constants.getDateComps(date: Date()).day!
        
        let openM:Int = Int((voiceDic[String(selectedIndex+1)]?.components(separatedBy: "/")[0])!)!
        let openD:Int = Int((voiceDic[String(selectedIndex+1)]?.components(separatedBy: "/")[1])!)!

        
        if gInvInfoDic.count != 0, gInvInfoDic[selectedIndex]?.count != 0 {
            count = gInvInfoDic[selectedIndex]![0] as! Int
            bingo = gInvInfoDic[selectedIndex]![1] as! Int
            bingoMoney = gInvInfoDic[selectedIndex]![2] as! Int
            status = gInvInfoDic[selectedIndex]![3] as! String
        }

        self.count1.text = "\(count)"
        self.count2.text = "\(bingo)"
        self.count3.text = "\(bingoMoney)"
        
//        if selectedIndex+1 == 6 {
//            self.count21.text = "本期尚未開獎"
//            self.count22.isHidden = true
//            self.count23.isHidden = true
//            self.count31.isHidden = true
//            self.count32.isHidden = true
//            self.count33.isHidden = true
//            return
//        }
        
        if ((m >= openM) || (m == openM && d>=openD)) {
            if status == "0" {          // api回傳太多空格
                self.count21.text = "本期沒有中獎QQ"
                self.count22.isHidden = true
                self.count23.isHidden = true
                self.count31.isHidden = true
                self.count32.isHidden = true
                self.count33.isHidden = true
            }
            else if status == "1" {
                
            }
        }
        else {
            self.count21.text = "本期尚未開獎"
            self.count22.isHidden = true
            self.count23.isHidden = true
            self.count31.isHidden = true
            self.count32.isHidden = true
            self.count33.isHidden = true
        }
        
        /*
        if status == "0" {
            self.count21.text = "本期沒有中獎QQ"
            self.count22.isHidden = true
            self.count23.isHidden = true
            self.count31.isHidden = true
            self.count32.isHidden = true
            self.count33.isHidden = true
        }
        else if status == "1" {
            
        }
        else {
            self.count21.text = "本期尚未開獎"
            self.count22.isHidden = true
            self.count23.isHidden = true
            self.count31.isHidden = true
            self.count32.isHidden = true
            self.count33.isHidden = true
        }
        */
     }
    
    @IBAction override func doConfirm(_ sender:UIButton) {
        super.cancelModally()
    }

}
