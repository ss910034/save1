//
//  ProductDetailTableViewCell.swift
//  save
//
//  Created by Frank Liu on 2021/10/23.
//

import UIKit

class InvoiceRecordTableViewCell: UITableViewCell {

    @IBOutlet weak var date  : UILabel!
    @IBOutlet weak var dollarImg  : UIImageView!
    @IBOutlet weak var tool  : UILabel!
    @IBOutlet weak var desc  : UILabel!
    @IBOutlet weak var money  : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
