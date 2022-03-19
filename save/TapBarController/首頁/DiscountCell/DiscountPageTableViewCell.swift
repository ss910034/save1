//
//  ActivityTableViewCell.swift
//  HereHearV2
//
//  Created by Frank Liu on 2019/7/17.
//  Copyright © 2019 Frank Liu. All rights reserved.
//

import UIKit
import MessageUI

class DiscountPageTableViewCell: UITableViewCell {

    @IBOutlet weak var pic : UIImageView!
    @IBOutlet weak var desc : UILabel!
    @IBOutlet weak var price : UILabel!
    @IBOutlet weak var less : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
