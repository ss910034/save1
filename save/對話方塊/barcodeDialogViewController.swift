//
//  DialogViewController.swift
//  HereHearV2
//
//  Created by Frank Liu on 2019/6/24.
//  Copyright © 2019 Frank Liu. All rights reserved.
//

import UIKit
import SwiftyJSON

class barcodeDialogViewController: InfoDialogViewController {

    @IBOutlet weak var pic: UIImageView!

    override func viewDidLoad() {
        // super.viewDidLoad()
        self.view.isOpaque = false
        self.lab1.text = titleString
        self.lab2.attributedText = Constants.changeLineSpaceAndCenter(txtString: contentString, space: 2.0, fontSize: 16.0, fontColor: .black)
    }
    
    @IBAction override func doConfirm(_ sender:UIButton) {
        super.cancelModally()
    }

}
