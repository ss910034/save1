//
//  ActivityTableViewCell.swift
//  HereHearV2
//
//  Created by Frank Liu on 2019/7/17.
//  Copyright © 2019 Frank Liu. All rights reserved.
//

import UIKit
import MessageUI
import SwiftyJSON

class SellCellTableViewCell: UITableViewCell {

    @IBOutlet weak var love : UIImageView!
    @IBOutlet weak var pic : UIImageView!

    @IBOutlet weak var desc1 : UILabel!
    @IBOutlet weak var desc2 : UILabel!
    @IBOutlet weak var price : UILabel!

    var data:ProdutCateDetailData!
    var selectedRow = 0
    var parentVC:SellDetailViewController? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
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
                    self.love.image = UIImage(named: "lovelove")
                }
                else {
                    self.love.image = UIImage(named: "loveempty")
                }
                if let vc = self.parentVC {
                    vc.refreshData(row: self.selectedRow, isLove: status)
                }
            }
        }
    }
}
