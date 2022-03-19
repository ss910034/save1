//
//  UserTableViewCell.swift
//  save
//
//  Created by Frank Liu on 2021/10/25.
//

import UIKit

class CCCell4TableViewCell: UITableViewCell {

    var parentVC:CCViewController!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func send(_ sender:UIButton) {
        Constants.showInfoDialog(vc: parentVC, title: "提示", content: "我們將在2~3個工作天回覆您！", type: 0, isClose: 1)
    }
    
}
