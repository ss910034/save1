//
//  ChangeRecordViewController.swift
//  save
//
//  Created by Frank Liu on 2021/10/24.
//

import UIKit

class ChangeRecordViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var myTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTableView.register(ChangeRecordCellTableViewCell.nib, forCellReuseIdentifier: ChangeRecordCellTableViewCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func back() {
        self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 93.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChangeRecordCellTableViewCell.identifier, for: indexPath) as! ChangeRecordCellTableViewCell
        
        if indexPath.row == 2 || indexPath.row == 3 {
            cell.title.text = "參加抽獎"
            cell.subtitle.text = "【統一超商禮卷100元】"
            cell.money.text = "100"
        }
        return cell
    }

}
