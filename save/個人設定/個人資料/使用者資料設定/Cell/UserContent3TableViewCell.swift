//
//  UserTableViewCell.swift
//  save
//
//  Created by Frank Liu on 2021/10/25.
//

import UIKit

class UserContent3TableViewCell: UITableViewCell {

    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var btn1 : UIButton!
    @IBOutlet weak var btn2 : UIButton!

    @IBOutlet weak var line1 : UIView!
    @IBOutlet weak var line2 : UIView!
    var parentVC:UserSettingViewController!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func watch(_ sender:UIButton) {
        Constants.showInfoDialog(vc: gRootViewController, title: "提示", content: "目前的驗證碼是123456", type: 0, isClose: 0)
    }
    
    @IBAction func change(_ sender:UIButton) {
        let vc = ChangeCodeViewController()
        parentVC.navigationController?.pushViewController(vc, animated: true)
    }
    
}
