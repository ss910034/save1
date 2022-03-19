//
//  UserViewController.swift
//  save
//
//  Created by Frank Liu on 2021/10/25.
//

import UIKit

class UserViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var myTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTableView.register(UserTableViewCell.nib, forCellReuseIdentifier: UserTableViewCell.identifier)
        self.myTableView.register(TitleTableViewCell.nib, forCellReuseIdentifier: TitleTableViewCell.identifier)
        self.myTableView.register(UserCardTableViewCell.nib, forCellReuseIdentifier: UserCardTableViewCell.identifier)
        self.myTableView.register(GeneralTableViewCell.nib, forCellReuseIdentifier: GeneralTableViewCell.identifier)
        NotificationCenter.default.addObserver(self, selector: #selector(logout), name: NSNotification.Name(
            "ConfirmDialog"), object: nil)
        self.myTableView.backgroundColor = .clear
    }
    
    @objc func logout() {
        let vc = LoginViewController()
        gRootViewController.navigationController?.pushViewController(vc, animated: false)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 110.0
        }
        else if indexPath.row == 1 || indexPath.row == 4 || indexPath.row == 7 || indexPath.row == 14 {
            return 50.0
        }
        else if indexPath.row == 2 {
            return 189.0
        }
        else {
            return 66.0
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 16
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            let vc = UserSettingViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        if indexPath.row == 3 {
            let vc = ToolViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        if indexPath.row == 9 {
            let vc = FeedBackViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 10 {
            let vc = CCViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 15 {
            let vc = confirmDialogViewController()
            vc.titleString = "提示"
            vc.contentString = "確定要登出？"
            vc.type = 0
            vc.modalPresentationStyle = .overCurrentContext
            gRootViewController.present(vc, animated: false, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: UserTableViewCell.identifier, for: indexPath) as! UserTableViewCell
            
            return cell
        }
        else if indexPath.row == 1 || indexPath.row == 4 || indexPath.row == 7 || indexPath.row == 14 {
            let cell = tableView.dequeueReusableCell(withIdentifier: TitleTableViewCell.identifier, for: indexPath) as! TitleTableViewCell
            
            if indexPath.row == 1 {
                cell.pic.isHidden = false
                cell.pic2.isHidden = true
                cell.pic.image = UIImage(named: "u3")
            }
            if indexPath.row == 4 {
                cell.pic.image = UIImage(named: "u10")
                cell.pic2.isHidden = true
            }
            else if indexPath.row == 7 {
                cell.pic.image = UIImage(named: "u11")
                cell.pic2.isHidden = true
            }
            else if indexPath.row == 14 {
                cell.pic2.image = UIImage(named: "u12")
                cell.pic2.isHidden = false
                cell.pic.isHidden = true
            }
            else if indexPath.row == 1 {
                cell.pic.image = UIImage(named: "u3")
                cell.pic2.isHidden = true
            }
            return cell
        }
        else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: UserCardTableViewCell.identifier, for: indexPath) as! UserCardTableViewCell
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: GeneralTableViewCell.identifier, for: indexPath) as! GeneralTableViewCell
            if indexPath.row == 3  {
                cell.line2.isHidden = true
            }
            else if  indexPath.row == 5 || indexPath.row == 6 || indexPath.row == 8 || indexPath.row == 9 || indexPath.row == 10 || indexPath.row == 13 || indexPath.row == 15{
                cell.line1.isHidden = true
                if indexPath.row == 6 || indexPath.row == 13 || indexPath.row == 15 {
                    cell.line2.isHidden = true
                }
            }
            
            if indexPath.row == 10 {
                cell.line2.isHidden = true
            }
            
            if indexPath.row == 11 {
                cell.line1.isHidden = true
                cell.line2.isHidden = true
            }
            
            if indexPath.row == 3 {
                cell.name.text = "已歸戶載具"
            }
            if indexPath.row == 5 {
                cell.name.text = "分享給麻吉"
            }
            if indexPath.row == 6 {
                cell.name.text = "幫我們評分"
            }
            if indexPath.row == 8 {
                cell.name.text = "Q&A常見問題"
                cell.arrow.isHidden = true
            }
            if indexPath.row == 9 {
                cell.name.text = "意見回饋"
                cell.arrow.isHidden = true
            }
            if indexPath.row == 10 {
                cell.name.text = "合作洽談"
                cell.arrow.isHidden = true
            }
            if indexPath.row == 11 {
                cell.name.text = "服務條款及隱私宣告"
                cell.arrow.isHidden = true
            }
            if indexPath.row == 12 {
                cell.name.text = "省省吧Facebook粉絲團"
                cell.arrow.isHidden = true
            }
            if indexPath.row == 13 {
                cell.name.text = "省省吧Instagram"
                cell.arrow.isHidden = true
            }
            if indexPath.row == 15 {
                cell.name.text = "登出"
                cell.arrow.isHidden = true
            }
            if indexPath.row == 11 {
                cell.line1.isHidden = false
            }
            return cell
        }
    }

}
