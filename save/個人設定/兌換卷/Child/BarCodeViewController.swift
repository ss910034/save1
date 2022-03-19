//
//  BarCodeViewController.swift
//  save
//
//  Created by Frank Liu on 2021/10/24.
//

import UIKit

class BarCodeViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var myTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTableView.register(CouponCellTableViewCell.nib, forCellReuseIdentifier: CouponCellTableViewCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 129.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 1 {
            let vc = InfoDialogViewController()
            vc.type = 0
            vc.titleString = "提示"
            vc.contentString = "已兌換，若有問題請聯繫客服。"
            vc.modalPresentationStyle = .overCurrentContext
            gRootViewController.present(vc, animated: false, completion: nil)
        }
        else {
            let vc = BarCodeChangeViewController()
            gNav5?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CouponCellTableViewCell.identifier, for: indexPath) as! CouponCellTableViewCell
        
//        cell.pic.image = UIImage(named: String(format: "homeAdv%d", indexPath.row+1))
        if indexPath.row == 0 {
           
        }
        else {
            cell.pic.image = UIImage(named:"cpic2")
            cell.desc.text = "7-11 10元折價卷"
            cell.bg.image = UIImage(named: "cbg2")
        }

        return cell
    }

}
