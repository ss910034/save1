//
//  PutCodeViewController.swift
//  save
//
//  Created by Frank Liu on 2021/10/24.
//

import UIKit

class ChooseCardViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var myTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTableView.register(ChooseCardTableViewCell.nib, forCellReuseIdentifier: ChooseCardTableViewCell.identifier)
        self.myTableView.backgroundColor = .clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.tabBarController?.tabBar.isHidden = true
//    }
    
    @IBAction func newMem(_ sender:UIButton) {
        let vc = NewMemberCardViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // let cell = tableView.cellForRow(at: indexPath) as! ChooseCardTableViewCell
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = companyCodeDialogViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.parentVC = self
        gRootViewController.present(vc, animated: false, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChooseCardTableViewCell.identifier, for: indexPath) as! ChooseCardTableViewCell
        cell.imag.image = UIImage(named: String(format: "ca%d", indexPath.row+1))
        
        if indexPath.row == 0 {
            cell.desc.text = "屈臣氏"
        }
        if indexPath.row == 1{
            cell.desc.text = "順發3C"
        }
        else if indexPath.row == 2{
            cell.desc.text = "愛買"
        }
        else if indexPath.row == 3{
            cell.desc.text = "燦坤"
        }
        
        cell.backgroundColor = .clear
        return cell
    }

    
}
