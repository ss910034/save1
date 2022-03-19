//
//  UserViewController.swift
//  save
//
//  Created by Frank Liu on 2021/10/25.
//

import UIKit

class UserSettingViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var myTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTableView.register(UserTitleTableViewCell.nib, forCellReuseIdentifier: UserTitleTableViewCell.identifier)
        self.myTableView.register(UserContentTableViewCell.nib, forCellReuseIdentifier: UserContentTableViewCell.identifier)
        self.myTableView.register(UserContent2TableViewCell.nib, forCellReuseIdentifier: UserContent2TableViewCell.identifier)
        self.myTableView.register(UserContent3TableViewCell.nib, forCellReuseIdentifier: UserContent3TableViewCell.identifier)
        self.myTableView.backgroundColor = .clear
        NotificationCenter.default.addObserver(self, selector: #selector(refreshUserRow), name: NSNotification.Name("InputText"), object: nil)
    }
    
    @objc func refreshUserRow(_ not:Notification) {
        let cell:UserContentTableViewCell = myTableView.cellForRow(at: IndexPath(row: 1, section: 0)) as! UserContentTableViewCell
        cell.name2.text = not.userInfo!["name"] as? String
        // myTableView.reloadRows(at:  [IndexPath(row: 1, section: 0)], with: .automatic)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 || indexPath.row == 4 || indexPath.row == 9 {
            return 50.0
        }
        else if indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 5 || indexPath.row == 6 || indexPath.row == 7 || indexPath.row == 8 ||  indexPath.row == 10  {
            return 64.0
        }
        else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 1 {
            let cell:UserContentTableViewCell = tableView.cellForRow(at: indexPath) as! UserContentTableViewCell
            let vc = inputDialogViewController()
            vc.titleString = "名稱修改"
            vc.name = cell.name2.text!
            vc.modalPresentationStyle = .overCurrentContext
            gRootViewController.present(vc, animated: false, completion: nil)
        }
        else if indexPath.row == 2 {
            let cell:UserContentTableViewCell = self.myTableView.cellForRow(at: IndexPath(row: 2, section: 0)) as! UserContentTableViewCell
            let selection = BillDateSelectionVC.oneRowelectionController(.CUSTOME, data: ["男", "女"], defRow: cell.name2.text == "男" ? 0 : 1)
            selection?.frankSelectionOneRow = {(vc, data, row) in
                cell.name2.text = data
                // self.myTableView.reloadRows(at: [IndexPath(row: 2, section: 0)], with: .automatic)
            }
            selection?.cancelButtonAction = { vc in
                
            }
            
            selection?.show(in: gRootViewController, withTarget: selection)
        }
        else if indexPath.row == 3 {
            let cell:UserContentTableViewCell = self.myTableView.cellForRow(at: IndexPath(row: 3, section: 0)) as! UserContentTableViewCell
            let date = cell.name2.text
            let comps = date?.components(separatedBy: "/")
            let selection = BillDateSelectionVC.dateSelectionController(.THREEDATE, withYear: Int32(comps![0])!, withMonth: Int32(comps![1])!, endDay: Int32(comps![2])!, hour: 7, minute: 30)
            selection?.frankSelection3Block = {(vc, dateAry) in
                let y = dateAry![0] as! String
                let m = dateAry![1] as! String
                let d = dateAry![2] as! String
                let tmp:String = String(format: "%@/%@/%@", y, m, d)
                let tmp2 = tmp.replacingOccurrences(of: "年", with: "")
                let tmp3 = tmp2.replacingOccurrences(of: "月", with: "")
                let rc = tmp3.replacingOccurrences(of: "日", with: "")
                let cell:UserContentTableViewCell = self.myTableView.cellForRow(at: IndexPath(row: 3, section: 0)) as! UserContentTableViewCell
                cell.name2.text = rc
            }
            selection?.cancelButtonAction = { vc in
                
            }
            
            selection?.show(in: gRootViewController, withTarget: selection)
        }

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 || indexPath.row == 4 || indexPath.row == 9 {
            let cell = tableView.dequeueReusableCell(withIdentifier: UserTitleTableViewCell.identifier, for: indexPath) as! UserTitleTableViewCell
            cell.pic.image = UIImage(named: String(format: "user0%d", indexPath.row))
            if indexPath.row == 9 {
                cell.const.constant = 10
            }
            return cell
        }
        else if indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3 || indexPath.row == 10 {
            let cell = tableView.dequeueReusableCell(withIdentifier: UserContentTableViewCell.identifier, for: indexPath) as! UserContentTableViewCell
            if indexPath.row == 1 {
                cell.line1.isHidden = true
                cell.line2.isHidden = true
                cell.name.text = "姓名"
                cell.name2.text = "使用者"
            }
            if indexPath.row == 2 {
                cell.line2.isHidden = true
                cell.name.text = "性別"
                cell.name2.text = "男"
            }
            if indexPath.row == 3 {
                cell.line2.isHidden = true
                cell.name.text = "生日"
                cell.name2.text = "1974/5/25"
            }
            if indexPath.row == 10 {
                cell.line1.isHidden = true
                cell.line2.isHidden = true
                cell.name2.isHidden = true
                cell.name.text = "領獎帳戶設定"
            }
            return cell
        }
        else if indexPath.row == 5 || indexPath.row == 6 || indexPath.row == 7 {
            let cell = tableView.dequeueReusableCell(withIdentifier: UserContent2TableViewCell.identifier, for: indexPath) as! UserContent2TableViewCell
            if indexPath.row == 5 {
                cell.line1.isHidden = true
                cell.name.text = "手機條碼"
                cell.name2.text = "/EJKK44Q"
            }
            if indexPath.row == 6 || indexPath.row == 7 {
                cell.line1.isHidden = true
                if indexPath.row == 6 {
                    cell.name.text = "手機號碼"
                    cell.name2.text = "0928844005"
                }
                else {
                    cell.name.text = "電子信箱"
                    cell.name2.text = "gn831116@gmail.com"
                }
            }
            return cell
        }
        else if indexPath.row == 8 {
            let cell = tableView.dequeueReusableCell(withIdentifier: UserContent3TableViewCell.identifier, for: indexPath) as! UserContent3TableViewCell
                cell.line1.isHidden = true
                cell.line2.isHidden = true
            cell.name.text = "載具驗證碼"
            cell.parentVC = self
            return cell
        }
        return UITableViewCell()
    }
}
