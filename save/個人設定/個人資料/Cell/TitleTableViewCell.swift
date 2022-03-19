//
//  UserTableViewCell.swift
//  save
//
//  Created by Frank Liu on 2021/10/25.
//

import UIKit

class TitleTableViewCell: UITableViewCell {

    @IBOutlet weak var pic : UIImageView!
    @IBOutlet weak var pic2 : UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
