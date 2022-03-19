//
//  ActivityTableViewCell.swift
//  HereHearV2
//
//  Created by Frank Liu on 2019/7/17.
//  Copyright © 2019 Frank Liu. All rights reserved.
//

import UIKit
import MessageUI

class ChangeRecordCellTableViewCell: UITableViewCell {

    @IBOutlet weak var title : UILabel!
    @IBOutlet weak var subtitle : UILabel!
    @IBOutlet weak var money : UILabel!
    @IBOutlet weak var date : UILabel!

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
