//
//  UserTableViewCell.swift
//  save
//
//  Created by Frank Liu on 2021/10/25.
//

import UIKit

class CCCell1TableViewCell: UITableViewCell {

    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var field : UITextField!
    @IBOutlet weak var line1 : UIView!
    @IBOutlet weak var line2 : UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
