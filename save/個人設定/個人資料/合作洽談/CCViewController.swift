//
//  UserViewController.swift
//  save
//
//  Created by Frank Liu on 2021/10/25.
//

import UIKit

class CCViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate {

    @IBOutlet weak var myTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTableView.register(CCCell1TableViewCell.nib, forCellReuseIdentifier: CCCell1TableViewCell.identifier)
        self.myTableView.register(CCCell2TableViewCell.nib, forCellReuseIdentifier: CCCell2TableViewCell.identifier)
        self.myTableView.register(CCCell3TableViewCell.nib, forCellReuseIdentifier: CCCell3TableViewCell.identifier)
        self.myTableView.register(CCCell4TableViewCell.nib, forCellReuseIdentifier: CCCell4TableViewCell.identifier)
        self.myTableView.backgroundColor = .clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5 || indexPath.row == 7 {
            return 91
        }
        else if indexPath.row == 2 {
            return 147
        }
        else {
            return 290
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 || indexPath.row == 1 || indexPath.row == 3 || indexPath.row == 4 || indexPath.row == 5 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CCCell1TableViewCell.identifier, for: indexPath) as! CCCell1TableViewCell
            cell.line1.isHidden = true
            if indexPath.row == 0 {
                cell.name.text = "・公司/單位"
                cell.field.placeholder = "輸入名稱"
            }
            else if indexPath.row == 1 {
                cell.name.text = "・聯絡人"
                cell.field.placeholder = "輸入名稱"
            }
            else if indexPath.row == 3 {
                cell.name.text = "・聯絡信箱"
                cell.field.placeholder = "輸入信箱"
                cell.field.keyboardType = .emailAddress
            }
            else if indexPath.row == 4 {
                cell.name.text = "・聯絡電話"
                cell.field.placeholder = "輸入電話+分機 或是 行動電話"
                cell.field.keyboardType = .numbersAndPunctuation
            }
            else if indexPath.row == 5 {
                cell.name.text = "・合作主旨"
                cell.field.placeholder = "輸入主旨"

            }
            cell.backgroundColor = .clear
            cell.field.delegate = self
            cell.selectionStyle = .none
            return cell
        }
        
        if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CCCell2TableViewCell.identifier, for: indexPath) as! CCCell2TableViewCell
            cell.name.text = "・職稱"
            cell.field.placeholder = "輸入職稱"
            cell.field.delegate = self
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            return cell
        }
        
        if indexPath.row == 6 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CCCell3TableViewCell.identifier, for: indexPath) as! CCCell3TableViewCell
            cell.name.text = "・合作內容"
            cell.textView.text = "輸入內容"
            cell.backgroundColor = .clear
            cell.textView.delegate = self
            cell.selectionStyle = .none
            return cell
        }
        
        if indexPath.row == 7 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CCCell4TableViewCell.identifier, for: indexPath) as! CCCell4TableViewCell
            cell.backgroundColor = .clear
            cell.selectionStyle = .none
            cell.parentVC = self
            return cell
        }
    
        return UITableViewCell()
    }

    @IBAction func send(_ sender:UITapGestureRecognizer) {
        Constants.showInfoDialog(vc: gRootViewController, title: "提示", content: "我們將在2~3個工作天回覆您！", type: 0, isClose: 1)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "輸入內容"
            textView.textColor = UIColor.lightGray
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        return true
    }
}
