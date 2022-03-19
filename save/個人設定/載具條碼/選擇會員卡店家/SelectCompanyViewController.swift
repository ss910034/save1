//
//  SearchViewController.swift
//  save
//
//  Created by Frank Liu on 2021/10/23.
//

import UIKit
import iOSDropDown

var gDidSelectd = 0
var gDidSelectdName = ""

class SelectCompanyViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var dropDown : UITextField!
    @IBOutlet weak var notfound : UIImageView!
    @IBOutlet weak var notfoundbase : UIView!
    @IBOutlet weak var myTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTableView.register(SelectCompanyTableViewCell.nib, forCellReuseIdentifier: SelectCompanyTableViewCell.identifier)
        self.myTableView.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.tabBarController?.tabBar.isHidden = true
//    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let cell = tableView.cellForRow(at: indexPath) as! SelectCompanyTableViewCell
        tableView.deselectRow(at: indexPath, animated: true)
        gDidSelectd = indexPath.row + 1
        gDidSelectdName = cell.desc.text!
        super.back()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectCompanyTableViewCell.identifier, for: indexPath) as! SelectCompanyTableViewCell
        cell.imag.image = UIImage(named: String(format: "ss%d", indexPath.row+1))
        if indexPath.row == 0 {
            cell.desc.text = "7-11統一超商"
        }
        if indexPath.row == 1{
            cell.desc.text = "家樂福"
        }
        else if indexPath.row == 2{
            cell.desc.text = "全國電子"
        }
        else if indexPath.row == 3{
            cell.desc.text = "寶雅"
        }
        else if indexPath.row == 4{
            cell.desc.text = "萊爾富"
        }
        else if indexPath.row == 5{
            cell.desc.text = "美廉社"
        }
        else if indexPath.row == 6{
            cell.desc.text = "愛買"
        }
        else if indexPath.row == 7{
            cell.desc.text = "康是美"
        }
        
        gDidSelectdName = cell.desc.text!
        return cell
    }
    
    @IBAction func doSearch(_ sender: UIButton) {
//        dropDown.resignFirstResponder()
//        if dropDown.text != "" {
//            self.myTableView.isHidden = false
//            self.notfound.isHidden = true
//            self.view.bringSubviewToFront(self.myTableView)
//            updateDropMenu()
//            self.myTableView.reloadData()
//        }
//        else {
//            self.myTableView.isHidden = true
//            self.notfound.isHidden = false
//        }
        
        self.myTableView.isHidden = true
        self.notfound.isHidden = false
        self.notfoundbase.isHidden = false
    }
}
