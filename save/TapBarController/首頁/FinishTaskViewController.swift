//
//  ChangeRecordViewController.swift
//  save
//
//  Created by Frank Liu on 2021/10/24.
//

import UIKit

class FinishTaskViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var myTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTableView.register(FinishTaskCellTableViewCell.nib, forCellReuseIdentifier: FinishTaskCellTableViewCell.identifier)
        // self.tabBarController?.tabBar.isHidden = true
    }
    
    override func back() {
        self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // self.tabBarController?.tabBar.isHidden = false
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
        let cell = tableView.dequeueReusableCell(withIdentifier: FinishTaskCellTableViewCell.identifier, for: indexPath) as! FinishTaskCellTableViewCell
        
        if indexPath.row == 1 {
            cell.subtitle.text = "【全聯火鍋區產品】"
        }
        return cell
    }

}
