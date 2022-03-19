//
//  PageViewController.swift
//  Fennec
//
//  Created by 楷岷 張 on 2017/7/13.
//  Copyright © 2017年 Fennec. All rights reserved.
//

import UIKit

class PageViewController: BaseViewController {
    
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var img3: UIImageView!

    var index = 0
    var entryType = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        switch index {
        case 0:
            self.img1.image = UIImage(named: "sliderPic1")
            self.img2.image = UIImage(named: "sliderDesc1")
            self.img3.image = UIImage(named: "sliderDot1")
        case 1:
            self.img1.image = UIImage(named: "sliderPic2")
            self.img2.image = UIImage(named: "sliderDesc2")
            self.img3.image = UIImage(named: "sliderDot2")
        case 2:
            self.img1.image = UIImage(named: "sliderPic3")
            self.img2.image = UIImage(named: "sliderDesc3")
            self.img3.image = UIImage(named: "sliderDot3")
        default:
            break
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       
        self.view.layoutIfNeeded()

        ///AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)       // Or to rotate and lock
       // AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
       
   }

   override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       
       // Don't forget to reset when view is being removed
       //AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.all)
   }
    
    @IBAction func dismissView() {
//        Constants.setFirstHomeGuideShow()
//        self.navigationController?.popViewController(animated: false)
//        NotificationCenter.default.post(name: NSNotification.Name("SlidePageFinish"), object: nil, userInfo: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
}
