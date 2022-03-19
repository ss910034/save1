//
//  UserTableViewCell.swift
//  save
//
//  Created by Frank Liu on 2021/10/25.
//

import UIKit

class UserContentTableViewCell: UITableViewCell {

    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var name2 : UILabel!
    @IBOutlet weak var arrow : UIImageView!
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
