//
//  HomeDetailViewController.swift
//  save
//
//  Created by Frank Liu on 2021/10/21.
//

import UIKit

class PromoteTasekViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func back() {
        self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // self.tabBarController?.tabBar.isHidden = false
    }
}
