//
//  SearchViewController.swift
//  save
//
//  Created by Frank Liu on 2021/10/23.
//

import UIKit
import iOSDropDown

class SearchDooViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var dropDown : UITextField!
    @IBOutlet weak var notfound : UIImageView!
    @IBOutlet weak var myTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTableView.register(DooTableViewCell.nib, forCellReuseIdentifier: DooTableViewCell.identifier)
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
        return 74.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        super.back()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DooTableViewCell.identifier, for: indexPath) as! DooTableViewCell
        if indexPath.row == 0 {
            cell.desc1.text = "2567"
            cell.desc2.text = "(雷射協會)台灣雷射應用發展協會"
        }
        if indexPath.row == 1 || indexPath.row == 4 || indexPath.row == 7{
            cell.desc1.text = "5372676"
            cell.desc2.text = "(婦保會)社團法人雲林縣婦女保護會"
        }
        else if indexPath.row == 2 || indexPath.row == 5 {
            cell.desc1.text = "137"
            cell.desc2.text = "(康寧大學)康寧學校財團法人康寧大學"
        }
        else if indexPath.row == 3 || indexPath.row == 6 {
            cell.desc1.text = "71583"
            cell.desc2.text = "岡山大專青年協會"
        }

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
    }

}
