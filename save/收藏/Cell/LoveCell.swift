//
//  CollectionCell.swift
//  HereHearV2
//
//  Created by Frank Liu on 2020/5/20.
//  Copyright © 2020 Frank Liu. All rights reserved.
//

import UIKit
import SwiftUI
import SwiftyJSON

class LoveCell: UICollectionViewCell {

    @IBOutlet weak var imgView  : UIImageView!
    @IBOutlet weak var productPic  : UIImageView!
    @IBOutlet weak var loveimg  : UIImageView!
    @IBOutlet weak var price  : UILabel!
    @IBOutlet weak var text  : UILabel!
    
    var data:ProdutCateDetailData!
    var selectedRow = 0
    var parentVC:ProductDetailViewController? = nil
    var parentVC2:Tap3ViewController? = nil
    var parentVC3:SellDetailViewController? = nil

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBAction func doLove(_ sender: UIButton) {
        var status = ""
        if data.isCollect == "1" {
            status = "0"
        }
        else {
            status = "1"
        }
        APIManager.shared.doLoveAction(isShow: true, barCode: data.barcodex, isLove: status) { sta, JSON in
            let json:JSON! = JSON
            if json["status"] == "1" {
                if status == "1" {
                    self.loveimg.image = UIImage(named: "lovelove")
                }
                else {
                    self.loveimg.image = UIImage(named: "loveempty")
                }
                if let vc = self.parentVC {
                    vc.refreshData(row: self.selectedRow, isLove: status)
                }
                if let vc = self.parentVC2 {
                    vc.refresh()
                }
                if let vc = self.parentVC3 {
                    vc.refreshData(row: self.selectedRow, isLove: status)
                }
            }
        }
    }
}
