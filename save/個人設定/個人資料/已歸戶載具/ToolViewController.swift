//
//  UserViewController.swift
//  save
//
//  Created by Frank Liu on 2021/10/25.
//

import UIKit

class ToolViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var myTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTableView.register(ToolTableViewCell.nib, forCellReuseIdentifier: ToolTableViewCell.identifier)
        self.myTableView.backgroundColor = .clear
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 117
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ToolTableViewCell.identifier, for: indexPath) as! ToolTableViewCell
        cell.pic.image = UIImage(named: String(format: "u%d", indexPath.row+4))
        cell.card.image = UIImage(named: String(format: "t%d", indexPath.row+1))
        if indexPath.row == 0 {
            cell.cardDesc.text = "信用卡-中國信託"
        }
        else if indexPath.row == 1 {
            cell.cardDesc.text = "悠遊卡-123"
        }
        else if indexPath.row == 2 {
            cell.cardDesc.text = "icash-123"
        }
        else if indexPath.row == 3 {
            cell.cardDesc.text = "一卡通-123"
        }
        else if indexPath.row == 4 {
            cell.cardDesc.text = "載具-123"
        }
        else if indexPath.row == 5 {
            cell.cardDesc.text = "電子商務-123"
        }
        return cell
    }
}
