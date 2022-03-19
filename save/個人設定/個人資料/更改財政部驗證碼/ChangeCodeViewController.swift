//
//  UserViewController.swift
//  save
//
//  Created by Frank Liu on 2021/10/25.
//

import UIKit

class ChangeCodeViewController: BaseViewController {

    override func viewDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(back), name: NSNotification.Name(
            "CloseInfoDialog2"), object: nil)
    }
    
    @objc override func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func send(_ sender:UITapGestureRecognizer) {
        Constants.showInfoDialog(vc: gRootViewController, title: "提示", content: "驗證成功！", type: 0, isClose: 2)
    }
    
}
