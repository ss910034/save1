//
//  DialogViewController.swift
//  HereHearV2
//
//  Created by Frank Liu on 2019/6/24.
//  Copyright © 2019 Frank Liu. All rights reserved.
//

import UIKit
import SwiftyJSON

class countDialogViewController: InfoDialogViewController {

    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var dal1: UILabel!
    @IBOutlet weak var dal2: UILabel!
    var num = 1
    override func viewDidLoad() {
        // super.viewDidLoad()
        self.view.isOpaque = false
        self.lab1.text = titleString
        self.lab2.attributedText = Constants.changeLineSpaceAndCenter(txtString: contentString, space: 2.0, fontSize: 16.0, fontColor: .black)
    }
    
    @IBAction override func doConfirm(_ sender:UIButton) {
        super.cancelModally()
    }
    
    @IBAction func doCancel(_ sender:UIButton) {
        super.cancelModally()
    }
    
    @IBAction func down(_ sender:UITapGestureRecognizer) {
        if num == 1 {
            return
        }
        num -= 4
        self.dal1.text = "\(num)"
        self.dal2.text = "100"
        self.dal1.textColor = Constants.getDefaultTextColor()
        self.dal2.textColor = .systemYellow
    }

    @IBAction func up(_ sender:UITapGestureRecognizer) {
        if num == 5 {
            return
        }
        num += 4
        self.dal1.text = "\(num)"
        self.dal2.text = "500"
        self.dal1.textColor = .systemRed
        self.dal2.textColor = .systemRed
    }
}
