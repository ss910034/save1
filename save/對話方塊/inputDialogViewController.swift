//
//  DialogViewController.swift
//  HereHearV2
//
//  Created by Frank Liu on 2019/6/24.
//  Copyright © 2019 Frank Liu. All rights reserved.
//

import UIKit
import SwiftyJSON

class inputDialogViewController: InfoDialogViewController {

    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var field: UITextField!

    var name = ""
    
    override func viewDidLoad() {
        // super.viewDidLoad()
        self.view.isOpaque = false
        self.field.text = name
    }
    
    @IBAction override func doConfirm(_ sender:UIButton) {
        super.cancelModally()
        NotificationCenter.default.post(name: NSNotification.Name("InputText"), object: nil, userInfo: ["name" : field.text!])
    }
    
    @IBAction func doCancel(_ sender:UIButton) {
        super.cancelModally()
    }

}
