//
//  PutCodeViewController.swift
//  save
//
//  Created by Frank Liu on 2021/10/24.
//

import UIKit

var gPut:UIViewController!

class PutCodeViewController: BaseViewController {

    @IBOutlet weak var phoneCode: UILabel!
    @IBOutlet weak var barCode: UIImageView!
    @IBOutlet weak var doo: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        gPut = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // self.tabBarController?.tabBar.isHidden = false
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.tabBarController?.tabBar.isHidden = true
//    }

    @IBAction func showCode() {
        let vc = companyCodeDialogViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.parentVC = self
        gRootViewController.present(vc, animated: false, completion: nil)
    }
    
    @IBAction func action1(_ sender:UIButton) {
        let btn = self.view.viewWithTag(102) as! UIButton
        btn.setImage(UIImage(named: "put4"), for: .normal)
        sender.setImage(UIImage(named: "put3"), for: .normal)
        self.doo.isHidden = true
        self.phoneCode.isHidden = false
        self.barCode.isHidden = false
    }
    
    @IBAction func action2(_ sender:UIButton) {
        let btn = self.view.viewWithTag(101) as! UIButton
        btn.setImage(UIImage(named: "put33"), for: .normal)
        sender.setImage(UIImage(named: "put44"), for: .normal)
        self.doo.isHidden = false
        self.phoneCode.isHidden = true
        self.barCode.isHidden = true
    }
    
    @IBAction func chooseDoo(_ sender:UITapGestureRecognizer) {
        let vc = SearchDooViewController()
        gRootViewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func newMem(_ sender:UIButton) {
        let vc = NewMemberCardViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func chooseCard(_ sender:UIButton) {
        let vc = ChooseCardViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
