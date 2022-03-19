//
//  NewMemberCardViewController.swift
//  save
//
//  Created by Frank Liu on 2021/10/25.
//

import UIKit

class NewMemberCardViewController: BaseViewController {

    @IBOutlet weak var imag  : UIImageView!
    @IBOutlet weak var lab  : UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(back), name: NSNotification.Name(
            "CloseInfoDialog2"), object: nil)
    }

//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        NotificationCenter.default.removeObserver(self)
//    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
        if gDidSelectd != 0 {
            imag.image = UIImage(named: String(format: "ss%d", gDidSelectd))
            lab.text = gDidSelectdName
            lab.textColor = .red
        }
    }
    
    override func back() {
        self.navigationController?.popToViewController(gPut, animated: true)
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.tabBarController?.tabBar.isHidden = true
//    }

    @IBAction func save(_ sender:UIButton) {
        Constants.showInfoDialog(vc: gRootViewController, title: "提示", content: "新增成功", type: 0, isClose: 2)
    }
    
    @IBAction func scanMembar(_ sender:UITapGestureRecognizer) {
        let vc = MemberScanCardViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func chooseComp(_ sender:UITapGestureRecognizer) {
        let vc = SelectCompanyViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
