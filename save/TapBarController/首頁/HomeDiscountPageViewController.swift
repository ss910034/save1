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


class HomeDiscountPageViewController : BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTableView.register(DiscountPageTableViewCell.nib, forCellReuseIdentifier: DiscountPageTableViewCell.identifier)
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
        return 6
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DiscountPageTableViewCell.identifier, for: indexPath) as! DiscountPageTableViewCell
        
        if indexPath.row % 3 == 0 {
            cell.pic.image = UIImage(named: String(format: "disPic%d", (indexPath.row%3)+1))
            cell.desc.text = "波蜜果菜汁TP250ml"
            cell.price.text = "$10"

            let normalText = "7-11春節聯促第2件6折-0116*0LN6* "
            let normalString = NSMutableAttributedString(string:normalText)

            let boldText = "-4元"
            let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)]
            let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)
            
            normalString.append(attributedString)
            // attributedString.append(normalString)
            // cell.less.text = "7-11春節聯促第2件6折-0116*0LN6* -4元"
            cell.less.attributedText = normalString
        }
        else if indexPath.row % 3 == 1 {
            cell.pic.image = UIImage(named: String(format: "disPic%d", (indexPath.row%3)+1))
            cell.desc.text = "生活泡沫紅茶TP250ml"
            cell.price.text = "$10"
            // cell.less.text = "全家飲料促 -4元"
            let normalText = "全家飲料促 "
            let normalString = NSMutableAttributedString(string:normalText)

            let boldText = "-4元"
            let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)]
            let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)
            
            normalString.append(attributedString)
            // attributedString.append(normalString)
            // cell.less.text = "7-11春節聯促第2件6折-0116*0LN6* -4元"
            cell.less.attributedText = normalString
        }
        else if indexPath.row % 3 == 2 {
            cell.pic.image = UIImage(named: String(format: "disPic%d", (indexPath.row%3)+1))
            cell.desc.text = "盛香珍小魚花生300g"
            cell.price.text = "$49"
            // cell.less.text = "全聯兩件80元 -18元"
            let normalText = "全聯兩件80元 "
            let normalString = NSMutableAttributedString(string:normalText)

            let boldText = "-18元"
            let attrs = [NSAttributedString.Key.font : UIFont.boldSystemFont(ofSize: 14)]
            let attributedString = NSMutableAttributedString(string:boldText, attributes:attrs)
            
            normalString.append(attributedString)
            // attributedString.append(normalString)
            // cell.less.text = "7-11春節聯促第2件6折-0116*0LN6* -4元"
            cell.less.attributedText = normalString
        }
        
        return cell
    }


}
