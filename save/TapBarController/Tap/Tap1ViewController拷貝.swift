//
//  Tap1ViewController.swift
//  save
//
//  Created by Frank Liu on 2021/10/21.
//

import UIKit
import DTPagerController
import SwiftyJSON

class Tap1ViewController: BaseViewController, DTPagerControllerDelegate {

    @IBOutlet weak var childView:UIView!
    var pager:HomePagerViewController = HomePagerViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.pager.view.frame = CGRect(x: 0, y: 0, width: childView.frame.size.width, height: childView.frame.size.height)
        self.pager.view.backgroundColor = .clear
        self.childView.backgroundColor = .clear
        self.childView.addSubview(pager.view)
        self.pager.delegate = self
    }
    
    func pagerController(_ pagerController: DTPagerController, didChangeSelectedPageIndex index: Int) {
        print(index)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
}
