//
//  UserTableViewCell.swift
//  save
//
//  Created by Frank Liu on 2021/10/25.
//

import UIKit

class UserTableViewCell : UITableViewCell {

    @IBOutlet weak var pic : UIImageView!
    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var lab : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
