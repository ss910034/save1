//
//  CollectionCell.swift
//  HereHearV2
//
//  Created by Frank Liu on 2020/5/20.
//  Copyright © 2020 Frank Liu. All rights reserved.
//

import UIKit
import SwiftUI

class ChangeCell: UICollectionViewCell {

    @IBOutlet weak var imgView  : UIImageView!
    @IBOutlet weak var productPic  : UIImageView!
    @IBOutlet weak var change  : UIImageView!
    @IBOutlet weak var money  : UILabel!
    @IBOutlet weak var desc  : UILabel!
    @IBOutlet weak var left  : UILabel!
    @IBOutlet weak var date  : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
