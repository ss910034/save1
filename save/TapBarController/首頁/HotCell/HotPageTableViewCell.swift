//
//  ActivityTableViewCell.swift
//  HereHearV2
//
//  Created by Frank Liu on 2019/7/17.
//  Copyright © 2019 Frank Liu. All rights reserved.
//

import UIKit
import MessageUI

class HotPageTableViewCell: UITableViewCell {

    @IBOutlet weak var award : UIImageView!
    @IBOutlet weak var love : UIImageView!
    @IBOutlet weak var pic : UIImageView!

    @IBOutlet weak var awardText : UILabel!
    @IBOutlet weak var up : UILabel!
    @IBOutlet weak var desc1 : UILabel!
    @IBOutlet weak var desc2 : UILabel!
    @IBOutlet weak var price : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        award.image = nil
        love.image = nil
        pic.image = nil
    }
}
