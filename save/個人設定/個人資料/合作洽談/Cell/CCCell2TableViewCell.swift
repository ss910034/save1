//
//  UserTableViewCell.swift
//  save
//
//  Created by Frank Liu on 2021/10/25.
//

import UIKit

class CCCell2TableViewCell: UITableViewCell {

    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var field : UITextField!
    @IBOutlet weak var line1 : UIView!
    @IBOutlet weak var line2 : UIView!
    @IBOutlet weak var check1 : UIImageView!
    @IBOutlet weak var check2 : UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func check1(_ sender:UIButton) {
        self.check1.isHidden = false
        self.check2.isHidden = true
    }
    
    @IBAction func check2(_ sender:UIButton) {
        self.check1.isHidden = true
        self.check2.isHidden = false
    }
    
}
