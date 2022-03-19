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


class HomeHotPageViewController : BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTableView.register(HotPageTableViewCell.nib, forCellReuseIdentifier: HotPageTableViewCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HotPageTableViewCell.identifier, for: indexPath) as! HotPageTableViewCell
        
//        cell.pic.image = UIImage(named: String(format: "homeAdv%d", indexPath.row+1))
        if indexPath.row % 4 == 0 {
            cell.pic.image = UIImage(named: String(format: "hotpic%d", (indexPath.row%4)+1))
            cell.love.image = UIImage(named: "hotLoveRed")
        }
        else if indexPath.row % 4 == 1 {
            cell.pic.image = UIImage(named: String(format: "hotpic%d", (indexPath.row%4)+1))
            cell.love.image = UIImage(named: "hotLoveWhite")
            cell.desc1.text = "生活泡沫紅茶TP250ml"
            cell.desc2.text = "62,338人已購買"
        }
        else if indexPath.row % 4 == 2 {
            cell.pic.image = UIImage(named: String(format: "hotpic%d", (indexPath.row%4)+1))
            cell.love.image = UIImage(named: "hotLoveWhite")
            cell.desc1.text = "樂事分享包"
            cell.desc2.text = "62,338人已購買"
        }
        else if indexPath.row % 4 == 3 {
            cell.pic.image = UIImage(named: String(format: "hotpic%d", (indexPath.row%4)+1))
            cell.love.image = UIImage(named: "hotLoveWhite")
            cell.desc1.text = "波蜜果菜汁TP250ml"
            cell.desc2.text = "62,338人已購買"
        }
        
        if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 2 {
            cell.award.image = UIImage(named: "hotno\(indexPath.row+1)")
            cell.award.isHidden = false
            cell.awardText.isHidden = true
        }
        else {
            cell.award.isHidden = true
            cell.awardText.isHidden = false
            cell.awardText.text = "\(indexPath.row + 1)"
            if indexPath.row == 10 || indexPath.row == 11 {
                cell.awardText.textColor = .black
            }
            else {
                cell.awardText.textColor = .systemYellow
            }
        }
        
        return cell
    }

}
