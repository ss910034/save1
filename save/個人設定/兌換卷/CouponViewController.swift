//
//  CouponViewController.swift
//  save
//
//  Created by Frank Liu on 2021/10/24.
//

import UIKit

class CouponViewController: BaseViewController, RMPScrollingMenuBarControllerDelegate {

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
        self.pager.menuBar.segCount = 2;
        
        var viewControllers:[UIViewController] = []
        
        
        let vc1 = BarCodeViewController()
        vc1.view.backgroundColor = .white
        // let nav1 = UINavigationController(rootViewController: vc1)
        viewControllers.append(vc1)

        let vc2 = MailChangeViewController(nibName: "BarCodeViewController", bundle: nil)
        vc2.view.backgroundColor = .white
        // let nav2 = UINavigationController(rootViewController: vc2)
        viewControllers.append(vc2)
        
        self.pager.setViewControllers(viewControllers, animated: false)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
            self.pager.selectedIndex = 0
        }
        self.childView.addSubview(pager.view)
    }

    func menuBarController(_ menuBarController: RMPScrollingMenuBarController!, menuBarItemAt index: Int) -> RMPScrollingMenuBarItem! {
        let item = RMPScrollingMenuBarItem()
        
        if index == 0 {
            item.title = "條碼兌換"
        }
        else {
            item.title = "郵寄兌換"
        }
        
        let btn = item.button()
        btn?.setTitleColor(Constants.getDefaultTextColor(), for: .normal)
        btn?.setTitleColor(Constants.getDefaultTextColor(), for: .disabled)
        btn?.setTitleColor(Constants.getYellowColor(), for: .selected)
        
        if (index == 0) {
            btn?.titleEdgeInsets = UIEdgeInsets(top: 0, left: -40, bottom: 0, right: 0);
        }
        else {
            btn?.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -40);
        }
        return item
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // self.tabBarController?.tabBar.isHidden = false
        NotificationCenter.default.removeObserver(self)
    }
    
    override func back() {
        self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }
}
