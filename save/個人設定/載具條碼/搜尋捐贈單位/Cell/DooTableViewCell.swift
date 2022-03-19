//
//  ProductDetailTableViewCell.swift
//  save
//
//  Created by Frank Liu on 2021/10/23.
//

import UIKit

class DooTableViewCell: UITableViewCell {

    @IBOutlet weak var desc1  : UILabel!
    @IBOutlet weak var desc2  : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
