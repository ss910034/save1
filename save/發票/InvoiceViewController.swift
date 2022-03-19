//
//  ProductDetailViewController.swift
//  save
//
//  Created by Frank Liu on 2021/10/23.
//

import UIKit
import SwiftyJSON

class InvoiceViewController: BaseViewController, RMPScrollingMenuBarControllerDelegate {

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
        
        let vc1 = ScanProductViewController()
        vc1.view.tag = 100
        vc1.view.backgroundColor = .white
        // let nav1 = UINavigationController(rootViewController: vc1)
        viewControllers.append(vc1)
        
        let vc2 = ScanInvoiceViewController()
        vc2.view.tag = 200
        vc2.view.backgroundColor = .white
        // let nav2 = UINavigationController(rootViewController: vc2)
        viewControllers.append(vc2)
        
        self.pager.setViewControllers(viewControllers, animated: false)
        self.childView.addSubview(self.pager.view)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // self.tabBarController?.tabBar.isHidden = false
        NotificationCenter.default.post(name: NSNotification.Name("RemoveScanNot"), object: nil)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func back() {
        self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func menuBarController(_ menuBarController: RMPScrollingMenuBarController!, menuBarItemAt index: Int) -> RMPScrollingMenuBarItem! {
        let item = RMPScrollingMenuBarItem()
        
        if index == 0 {
            item.title = "商品條碼搜尋"
        }
        else {
            item.title = "電子發票掃描"
        }
        
        let btn = item.button()
        btn?.setTitleColor(Constants.getDefaultTextColor(), for: .normal)
        btn?.setTitleColor(Constants.getDefaultTextColor(), for: .disabled)
        btn?.setTitleColor(Constants.getYellowColor(), for: .selected)
        
        if (index == 0) {
            btn?.titleEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0);
        }
        else {
            btn?.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -20);
        }
        return item
    }
    
    func menuBarController(_ menuBarController: RMPScrollingMenuBarController!, didSelect viewController:UIViewController) {
        if viewController.view.tag == 100 {
            print("100")
            NotificationCenter.default.post(name: NSNotification.Name("ScanProduct"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name("StopScanInvoice"), object: nil)
        }
        else {
            print("200")
            NotificationCenter.default.post(name: NSNotification.Name("ScanInvoice"), object: nil)
            NotificationCenter.default.post(name: NSNotification.Name("StopScanProduct"), object: nil)
        }
    }

}
