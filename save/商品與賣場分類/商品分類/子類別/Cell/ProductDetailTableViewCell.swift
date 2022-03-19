//
//  ProductDetailTableViewCell.swift
//  save
//
//  Created by Frank Liu on 2021/10/23.
//

import UIKit

class ProductDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var name  : UILabel!
    @IBOutlet weak var price  : UILabel!
    @IBOutlet weak var activity  : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
