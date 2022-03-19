//
//  DialogViewController.swift
//  HereHearV2
//
//  Created by Frank Liu on 2019/6/24.
//  Copyright © 2019 Frank Liu. All rights reserved.
//

import UIKit
import SwiftyJSON

class confirmDialogViewController: InfoDialogViewController {

    @IBOutlet weak var cancel: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction override func doConfirm(_ sender:UIButton) {
        super.cancelModally()
        NotificationCenter.default.post(name: NSNotification.Name("ConfirmDialog"), object: nil)
    }
    
    @IBAction func doCancel(_ sender:UIButton) {
        super.cancelModally()
    }

}
