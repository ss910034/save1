//
//  NewMemberCardViewController.swift
//  save
//
//  Created by Frank Liu on 2021/10/25.
//

import UIKit

class MemberScanCardViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(back), name: NSNotification.Name(
            "CloseInfoDialog"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.tabBarController?.tabBar.isHidden = true
//    }

    @IBAction func save(_ sender:UIButton) {
        Constants.showInfoDialog(vc: gRootViewController, title: "提示", content: "新增成功", type: 0, isClose: 1)
    }
}
