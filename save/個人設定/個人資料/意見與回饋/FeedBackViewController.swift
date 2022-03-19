//
//  UserViewController.swift
//  save
//
//  Created by Frank Liu on 2021/10/25.
//

import UIKit

class FeedBackViewController: BaseViewController, UITextViewDelegate {

    @IBOutlet weak var q: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var top: NSLayoutConstraint!
    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var field: UITextField!
    @IBOutlet weak var line: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        hideInvoice(isHide: true)
        textView.text = "輸入內容"
        textView.textColor = UIColor.lightGray
        NotificationCenter.default.addObserver(self, selector: #selector(back), name: NSNotification.Name(
            "CloseInfoDialog2"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.tabBar.isHidden = false
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
    
    @objc override func back() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func choose(_ sender:UITapGestureRecognizer) {
        let selection = BillDateSelectionVC.oneRowelectionController(.CUSTOME, data: ["一般問題", "發票問題"], defRow: (q.text == "一般問題" || q.text == "請選擇") ? 0 : 1)
        selection?.frankSelectionOneRow = {(vc, data, row) in
            self.q.text = data
            self.q.textColor = Constants.getDefaultTextColor()
            if row == 0 {
                self.hideInvoice(isHide: true)
            }
            else {
                self.hideInvoice(isHide: false)
            }
        }
        selection?.cancelButtonAction = { vc in
            
        }
        
        selection?.show(in: gRootViewController, withTarget: selection)
    }
    
    @IBAction func send(_ sender:UITapGestureRecognizer) {
        Constants.showInfoDialog(vc: gRootViewController, title: "提示", content: "謝謝您的寶貴意見，我們將在3~5個工作天回覆您！", type: 0, isClose: 2)
    }
    
    func hideInvoice(isHide:Bool) {
        if isHide {
            top.constant = 22
            img.isHidden = true
            field.isHidden = true
            line.isHidden = true
        }
        else {
            top.constant = 120
            img.isHidden = false
            field.isHidden = false
            line.isHidden = false
        }
    }
}
