//
//  ActivityPageViewController.swift
//  HereHearV2
//
//  Created by Frank Liu on 2020/5/6.
//  Copyright © 2020 Frank Liu. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher


class HomePageViewController : BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myTableView: UITableView!

    var selectedIndex:Int = 2
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTableView.register(HomePageTableViewCell.nib, forCellReuseIdentifier: HomePageTableViewCell.identifier)
        self.myTableView.register(HomePage2TableViewCell.nib, forCellReuseIdentifier: HomePage2TableViewCell.identifier)

        myTableView.delegate = self
        myTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 260.0
        }
        return 248.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0  {
            return
        }
        let vc = PromoteTasekViewController()
        gNav1?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: HomePage2TableViewCell.identifier, for: indexPath) as! HomePage2TableViewCell
            cell.selectionStyle = .none
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: HomePageTableViewCell.identifier, for: indexPath) as! HomePageTableViewCell
        
        cell.pic.image = UIImage(named: String(format: "homeAdv%d", indexPath.row))
        if indexPath.row == 0 {
            cell.desc.text = "消費登陸含有「全聯自助咖啡」，可重複領取！";
        }
        else if indexPath.row == 1 {
            cell.desc.text = "消費登陸含有「全聯鑄鐵鍋」，可重複領取！";
        }
        else if indexPath.row == 2 {
            cell.desc.text = "至全聯消費生活誌指定泡麵兩件，可重複領取！";
        }
        else if indexPath.row == 3 {
            cell.desc.text = "消費登入「全聯火鍋區產品」，可重複領取！";
        }
        return cell
    }

}
