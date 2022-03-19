//
//  ActivityTableViewCell.swift
//  HereHearV2
//
//  Created by Frank Liu on 2019/7/17.
//  Copyright © 2019 Frank Liu. All rights reserved.
//

import UIKit
import MessageUI

class HomePage2TableViewCell: UITableViewCell {

    @IBOutlet weak var pic : UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    @IBAction func finishTask() {
        let vc = FinishTaskViewController()
        gNav1?.pushViewController(vc, animated: true)
    }
}
