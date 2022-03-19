//
//  DialogViewController.swift
//  HereHearV2
//
//  Created by Frank Liu on 2019/6/24.
//  Copyright © 2019 Frank Liu. All rights reserved.
//

import UIKit
import SwiftyJSON

var isDialogOpen = false

class InfoDialogViewController: BaseViewController {

    @IBOutlet weak var lab1: UILabel!
    @IBOutlet weak var lab2: UILabel!
    @IBOutlet weak var bg: UIImageView!
    @IBOutlet weak var confirm: UIButton!
    
    var titleString:String!
    var contentString:String!
    var type = 0 // 0: success,  1: fail
    var isClose = 0 // 0: don't,  1: do
    var parentVC:UIViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        rotateType = 1
        self.view.isOpaque = false
        self.lab1.text = titleString
        self.lab2.attributedText = Constants.changeLineSpaceAndCenter(txtString: contentString, space: 2.0, fontSize: 16.0, fontColor: .black)
        if type == 0 {
            self.bg.image = UIImage(named: "successBg")
        }
        else {
            self.bg.image = UIImage(named: "failBg")
        }
        isDialogOpen = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)       // Or to rotate and lock
       // AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
       
   }

   override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       
       // Don't forget to reset when view is being removed
       AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.all)
   }
    
    @IBAction func doConfirm(_ sender:UIButton) {
        super.cancelModally()
        if isClose == 1 {
            NotificationCenter.default.post(name: NSNotification.Name("CloseInfoDialog"), object: nil)
        }
        else if isClose == 2 {
            NotificationCenter.default.post(name: NSNotification.Name("CloseInfoDialog2"), object: nil)
        }
        isDialogOpen = false
    }
    
//   override func presentBarCodeView() {
////        let vc = ShowBarCodeViewController()
////        self.presentInFullScreen(vc, animated: true, completion: nil)
//    }

}
