//
//  MailChangeViewController.swift
//  save
//
//  Created by Frank Liu on 2021/10/24.
//

import UIKit

class MailChangeViewController: BarCodeViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            let vc = InfoDialogViewController()
            vc.type = 0
            vc.titleString = "提示"
            vc.contentString = "已兌換，若有問題請聯繫客服。"
            vc.modalPresentationStyle = .overCurrentContext
            gRootViewController.present(vc, animated: false, completion: nil)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CouponCellTableViewCell.identifier, for: indexPath) as! CouponCellTableViewCell
        
//        cell.pic.image = UIImage(named: String(format: "homeAdv%d", indexPath.row+1))
        if indexPath.row == 0 {
//            cell.desc.text = "統一超商 100禮卷"
//            cell.pic.image = UIImage(named:"cpic3")
            cell.desc.text = "7-11 10元折價卷"
            cell.bg.image = UIImage(named: "cbg2")
            cell.pic.image = UIImage(named:"cpic3")
        }
        else {
            cell.pic.image = UIImage(named:"cpic3")
            cell.desc.text = "7-11 10元折價卷"
            cell.bg.image = UIImage(named: "cbg2")
        }

        return cell
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
