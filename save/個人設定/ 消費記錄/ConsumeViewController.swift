//
//  CouponViewController.swift
//  save
//
//  Created by Frank Liu on 2021/10/24.
//

import UIKit

class ConsumeViewController: BaseViewController, RMPScrollingMenuBarControllerDelegate {

    @IBOutlet weak var childView:UIView!
    var selectedIndex = 0
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
        self.pager.menuBar.style = .infinitePaging
        self.pager.menuBar.segCount = 3;
        
        var viewControllers:[UIViewController] = []
        
        var index = 0
        for _ in stride(from: 1, through: 12, by: 2) {
            let vc = InvoiceRecordViewController()
            let nav = UINavigationController(rootViewController: vc)
            nav.view.tag = index
            viewControllers.append(nav)
            index += 1
        }
        
        // DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
            // self.pager.selectedIndex = 0
//            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ChangeInvoicePage"), object: nil, userInfo: ["index": self.selectedIndex])
        // }
        self.pager.setViewControllers(viewControllers, animated: false)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
            let comp = Constants.getDateComps(date: Date())
            let m = comp.month
            var idx = 0
            if m == 1 || m == 2 {
                idx = 0
            }
            else if m == 3 || m == 4 {
                idx = 1
            }
            else if m == 5 || m == 6 {
                idx = 2
            }
            else if m == 7 || m == 8 {
                idx = 3
            }
            else if m == 9 || m == 10 {
                idx = 4
            }
            else if m == 11 || m == 12 {
                idx = 5
            }
            self.pager.selectedIndex = idx
        }
        self.childView.addSubview(pager.view)
    }
    
    override func back() {
        self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func menuBarController(_ menuBarController: RMPScrollingMenuBarController!, menuBarItemAt index: Int) -> RMPScrollingMenuBarItem! {
        let item = RMPScrollingMenuBarItem()
        
        if index == 0 {
            item.title = "1-2月"
        }
        else if index == 1 {
            item.title = "3-4月"
        }
        else if index == 2 {
            item.title = "5-6月"
        }
        else if index == 3 {
            item.title = "7-8月"
        }
        else if index == 4 {
            item.title = "9-10月"
        }
        else if index == 5 {
            item.title = "11-12月"
        }
        
        let btn = item.button()
        btn?.setTitleColor(Constants.getDefaultTextColor(), for: .normal)
        btn?.setTitleColor(Constants.getDefaultTextColor(), for: .disabled)
        btn?.setTitleColor(Constants.getYellowColor(), for: .selected)
        
        /*
        if (index == self.pager.selectedIndex - 1) {
            btn?.titleEdgeInsets = UIEdgeInsets(top: 0, left: -32, bottom: 0, right: 0);
        }
        else if index == self.pager.selectedIndex + 1 {
            btn?.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -32);
        }
        
        print("self.pager.selectedIndex %d", self.pager.selectedIndex)
        */
        
        return item
    }
    
    func menuBarController(_ menuBarController: RMPScrollingMenuBarController!, willSelect viewController: UIViewController!) {
        
        self.selectedIndex = viewController.view.tag
        print(self.selectedIndex)
        DispatchQueue.main.asyncAfter(deadline: .now()+0.3) {
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "ChangeInvoicePage"), object: nil, userInfo: ["index": self.selectedIndex])
        }
    }
    
    func menuBarController(_ menuBarController: RMPScrollingMenuBarController!, didSelect viewController: UIViewController!) {
        
    }
    
    func menuBarController(_ menuBarController: RMPScrollingMenuBarController!, didCancel viewController: UIViewController!) {
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // self.tabBarController?.tabBar.isHidden = false
        //NotificationCenter.default.removeObserver(self)
        gInvInfoDic.removeAll()
    }
    
    @IBAction func open() {
        let d = invoiceDialogViewController()
        d.selectedIndex = selectedIndex
        d.modalPresentationStyle = .overCurrentContext
        gRootViewController.present(d, animated: false, completion: nil)
    }
}
