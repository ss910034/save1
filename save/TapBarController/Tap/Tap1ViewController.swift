//
//  Tap1ViewController.swift
//  save
//
//  Created by Frank Liu on 2021/10/21.
//

import UIKit
import SwiftyJSON

class Tap1ViewController: BaseViewController, RMPScrollingMenuBarControllerDelegate {

    @IBOutlet weak var childView:UIView!
    var pager:RMPScrollingMenuBarController = RMPScrollingMenuBarController()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.pager.view.frame = CGRect(x: 0, y: 0, width: childView.frame.size.width, height: childView.frame.size.height)
        self.pager.menuBar.mode = 1
        self.pager.view.backgroundColor = .clear
        self.childView.backgroundColor = .clear
        self.pager.delegate = self;
        // Customize appearance of menu bar.
        self.pager.menuBar.indicatorColor = Constants.getYellowColor()
        self.pager.menuBar.style = .normal
        self.pager.menuBar.segCount = 3;
        
        var viewControllers:[UIViewController] = []
        isToDetail = false
        let vc1 = HomeDiscountPageViewController()
        vc1.view.backgroundColor = .white
        viewControllers.append(vc1)
        
        let vc2 = HomePageViewController()
        vc2.view.backgroundColor = .white
        viewControllers.append(vc2)
        
        let vc3 = HomeHotPageViewController()
        vc3.view.backgroundColor = .white
        viewControllers.append(vc3)
        
        self.pager.setViewControllers(viewControllers, animated: false)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.05) {
            self.pager.selectedIndex = 1
        }
        self.childView.addSubview(pager.view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    func menuBarController(_ menuBarController: RMPScrollingMenuBarController!, menuBarItemAt index: Int) -> RMPScrollingMenuBarItem! {
        let item = RMPScrollingMenuBarItem()
        
        if index == 0 {
            item.title = "最新優惠"
        }
        else if index == 1 {
            item.title = "首頁l"
        }
        else {
            item.title = "熱門排行"
        }
        
        let btn = item.button()
        btn?.setTitleColor(Constants.getDefaultTextColor(), for: .normal)
        btn?.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        btn?.setTitleColor(Constants.getDefaultTextColor(), for: .disabled)
        btn?.setTitleColor(Constants.getYellowColor(), for: .selected)
        
        if (index == 0) {
            btn?.titleEdgeInsets = UIEdgeInsets(top: 0, left: -32, bottom: 0, right: 0);
        }
        if (index == 1) {
            btn?.titleEdgeInsets = UIEdgeInsets(top: 0, left: -0.8, bottom: 0, right: 0);
        }
        else if index == 2 {
            btn?.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -32);
        }
        return item
    }

}
