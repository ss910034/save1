//
//  DialogViewController.swift
//  HereHearV2
//
//  Created by Frank Liu on 2019/6/24.
//  Copyright © 2019 Frank Liu. All rights reserved.
//

import UIKit
import SwiftyJSON

class companyCodeDialogViewController: InfoDialogViewController {

    @IBOutlet weak var pic: UIImageView!

    override func viewDidLoad() {
        // super.viewDidLoad()
        self.view.isOpaque = false

    }
    
    @IBAction func cancel(_ sender:UITapGestureRecognizer) {
        super.cancelModally()
    }
    
    @IBAction func newMem(_ sender:UIButton) {
        let vc = NewMemberCardViewController()
        parentVC.navigationController?.pushViewController(vc, animated: true)
        super.cancelModally()
    }

}
