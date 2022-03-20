//
//  InputInvoiceViewController.swift
//  save
//
//  Created by Frank Liu on 2021/10/23.
//

import UIKit
import AVFoundation
import SwiftyJSON

class InputInvoiceViewController: BaseViewController {

    @IBOutlet weak var dateLab:UILabel!
    @IBOutlet weak var dateLab2:UILabel!
    @IBOutlet weak var field1: UITextField!
    @IBOutlet weak var field2: UITextField!
    @IBOutlet weak var field3: UITextField!
    @IBOutlet weak var field4: UITextField!
    @IBOutlet weak var field5: UITextField!
    @IBOutlet weak var saveBtn: UIButton!
    
    @IBOutlet weak var line1: UIView!
    @IBOutlet weak var line2: UIView!
    @IBOutlet weak var line3: UIView!
    @IBOutlet weak var line4: UIView!
    @IBOutlet weak var line5: UIView!
    @IBOutlet weak var line6: UIView!

    @IBOutlet weak var inputBg1: UIImageView!
    @IBOutlet weak var inputBg2: UIImageView!
    @IBOutlet weak var inputBg3: UIImageView!

    @IBOutlet weak var h1: NSLayoutConstraint!
    @IBOutlet weak var h2: NSLayoutConstraint!
    @IBOutlet weak var h3: NSLayoutConstraint!


    var year = 0
    var yearAD = 0
    var month = 0
    var day = 0
    var period = ""
    var dic:[Int:String] = [1 : "1-2",
                            2 : "1-2",
                            3 : "3-4",
                            4 : "3-4",
                            5 : "5-6",
                            6 : "5-6",
                            7 : "7-8",
                            8 : "7-8",
                            9 : "9-10",
                            10: "9-10",
                            11: "11-12",
                            12: "11-12"]
    let today = Date()
    var componets:DateComponents!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addDoneButtonOnKeyboard()
        field1.autocapitalizationType = .allCharacters
        saveBtn.isUserInteractionEnabled = false
        componets = today.get(.year, .month, .day)
        year = componets.year! - 1911
        month = componets.month!
        day = componets.day!
        dateLab.text = String(format: "%d年%@月", year, dic[month]!)
        period = String(format: "%03d%02d", year, month)
        self.tabBarController?.tabBar.isHidden = true
        setInputBgStatus()
    }
    
    func setInputBgStatus() {
        self.inputBg1.isHidden = true
        self.line1.isHidden = true
        self.h1.constant = 0
        self.inputBg2.isHidden = true
        self.line3.isHidden = true
        self.h2.constant = 0
        self.inputBg3.isHidden = true
        self.line5.isHidden = true
        self.h3.constant = 0
        self.dateLab2.isHidden = true
        self.field4.isHidden = true
        self.field5.isHidden = true
    }
    
    @IBAction func tap1(_ sender:UIButton) {
        self.inputBg1.isHidden = false
        self.line1.isHidden = false
        self.h1.constant = 51
        self.dateLab2.isHidden = false
        if field4.text != "" {
            self.inputBg2.isHidden = false
            self.line3.isHidden = false
            self.h2.constant = 51
            self.field4.isHidden = false
        }
        else {
            self.inputBg2.isHidden = true
            self.line3.isHidden = true
            self.h2.constant = 0
            self.field4.isHidden = true
        }
        if field5.text != "" {
            self.inputBg3.isHidden = false
            self.line5.isHidden = false
            self.h3.constant = 51
            self.field5.isHidden = false
        }
        else {
            self.inputBg3.isHidden = true
            self.line5.isHidden = true
            self.h3.constant = 0
            self.field5.isHidden = true
        }
    }

    @IBAction func tap2(_ sender:UIButton) {
        if dateLab2.text != "請輸入消費日期" {
            self.inputBg1.isHidden = false
            self.line1.isHidden = false
            self.h1.constant = 51
            self.dateLab2.isHidden = false
        }
        else {
            self.inputBg1.isHidden = true
            self.line1.isHidden = true
            self.h1.constant = 0
            self.dateLab2.isHidden = true
        }
        
        self.inputBg2.isHidden = false
        self.line3.isHidden = false
        self.h2.constant = 51
        self.field4.isHidden = false

        if field5.text != "" {
            self.inputBg3.isHidden = false
            self.line5.isHidden = false
            self.h3.constant = 51
            self.field5.isHidden = false
        }
        else {
            self.inputBg3.isHidden = true
            self.line5.isHidden = true
            self.h3.constant = 0
            self.field5.isHidden = true
        }
    }
    
    @IBAction func tap3(_ sender:UIButton) {
        if dateLab2.text != "請輸入消費日期" {
            self.inputBg1.isHidden = false
            self.line1.isHidden = false
            self.h1.constant = 51
            self.dateLab2.isHidden = false
        }
        else {
            self.inputBg1.isHidden = true
            self.line1.isHidden = true
            self.h1.constant = 0
            self.dateLab2.isHidden = true
        }
        if field4.text != "" {
            self.inputBg2.isHidden = false
            self.line3.isHidden = false
            self.h2.constant = 51
            self.field4.isHidden = false
        }
        else {
            self.inputBg2.isHidden = true
            self.line3.isHidden = true
            self.h2.constant = 0
            self.field4.isHidden = true
        }
        
        self.inputBg3.isHidden = false
        self.line5.isHidden = false
        self.h3.constant = 51
        self.field5.isHidden = false
    }
    
    @IBAction func dismissKey(_ sender:UITapGestureRecognizer) {
        self.field4.resignFirstResponder()
        self.field5.resignFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func back() {
        gScan1 = 0
        gScan2 = 0
        self.navigationController?.popViewController(animated: true)
        NotificationCenter.default.post(name: NSNotification.Name("ScanInvoice"), object: nil)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool  {

        let newLen = textField.text!.count + string.count - range.length
        
        if textField == field1 {
            if range.location >= 2 {
                return false
            }
            if newLen == 2 {
                textField.resignFirstResponder()
                field2.becomeFirstResponder()
                checkField()
            }
            if string == "" {
                textField.deleteBackward()
                checkField()
            } else {
                let char = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
                if !char.contains(string) {
                    return false
                }
                textField.insertText(string.uppercased())
                checkField()
            }
            // Do not let specified text range to be changed
            return false
        }
        
        if textField == field2 {
            if range.location >= 8 {
                return false
            }
            if newLen == 8 {
                textField.resignFirstResponder()
                field3.becomeFirstResponder()
                checkField()
            }
            if string == "" {
                textField.deleteBackward()
                checkField()
            } else {
                textField.insertText(string)
                checkField()
            }
            // Do not let specified text range to be changed
            return false
        }
        
        if textField == field3 {
            if range.location >= 4 {
                return false
            }
            if newLen == 4 {
                textField.resignFirstResponder()
                checkField()
            }
            if string == "" {
                textField.deleteBackward()
                checkField()
            } else {
                textField.insertText(string)
                checkField()
            }
            // Do not let specified text range to be changed
            return false
        }

        return true
    }
    
    func addDoneButtonOnKeyboard(){
        let doneToolbar: UIToolbar = UIToolbar(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50))
        doneToolbar.barStyle = .default

        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done: UIBarButtonItem = UIBarButtonItem(title: "確定", style: .done, target: self, action: #selector(self.doneButtonAction))

        let items = [flexSpace, done]
        doneToolbar.items = items
        doneToolbar.sizeToFit()

        field2.inputAccessoryView = doneToolbar
        field3.inputAccessoryView = doneToolbar
        field4.inputAccessoryView = doneToolbar
    }

    @objc func doneButtonAction(){
        field2.resignFirstResponder()
        field3.resignFirstResponder()
        field4.resignFirstResponder()
    }
    
    @IBAction func save() {
        var dateStr = ""
        if dateLab.text != "" {
            let y:String = (dateLab.text?.components(separatedBy: "-")[0])!
            let y2:String = (y.components(separatedBy: "年"))[0]
            let m:String = (y.components(separatedBy: "年")[1])
            let d:String = (dateLab.text?.components(separatedBy: "-")[1])!
            dateStr = String(format: "%@/%02d/%02d", y2, Int(m)!, Int(d.dropLast())!)
        }
        APIManager.shared.inputInvoice(isShow: true, invoiceNum: self.field1.text! + self.field2.text!, invoiceDate:dateStr, randomNm: field3.text!, period: period, sellerName: self.field5.text!, amout: self.field4.text!) { Status, JSON in
            let json:JSON! = JSON
            if json["status"].stringValue == "1", (json["prizeStatus"].stringValue == "0" || json["prizeStatus"].stringValue == "9") {
                Constants.showInfoDialog(vc: self, title: "新增成功", content: "新增成功！\n請保存紙本發票以供領獎使用！", type: 0, isClose: 0)
            }
            else if json["status"].stringValue == "1", json["prizeStatus"].stringValue == "1" {
                Constants.showInfoDialog(vc: self, title: "恭喜中獎", content: "恭喜中獎！\n請保存紙本發票以供領獎使用！", type: 0, isClose: 0)
            }
            else if json["status"].stringValue == "0" {
                Constants.showInfoDialog(vc: self, title: "新增失敗", content: "請重新輸入紙本發票！", type: 1, isClose: 0)
            }
        }
    }
    
    func checkField() {
        if field1.text != "" && field2.text != "" && field3.text != "" && dateLab2.text != "請輸入消費日期" && field1.text?.count == 2 && field2.text?.count == 8 && field3.text?.count == 4 {
            self.saveBtn.isUserInteractionEnabled = true
            self.saveBtn.setBackgroundImage(UIImage(named: "m7"), for: .normal)
        }
        else if field1.text != "" && field2.text != "" && dateLab2.text != "請輸入消費日期" && field1.text?.count == 2 && field2.text?.count == 8 {
            self.saveBtn.isUserInteractionEnabled = true
            self.saveBtn.setBackgroundImage(UIImage(named: "m7"), for: .normal)
        }
        else {
            self.saveBtn.isUserInteractionEnabled = false
            self.saveBtn.setBackgroundImage(UIImage(named: "m7_2"), for: .normal)
        }
    }
    
    @IBAction func previous() {
        month -= 2
        if month <= 0 {
            year -= 1
            month = 12
        }
        period = String(format: "%03d%02d", year, month)
        dateLab.text = String(format: "%d年%@月", year, dic[month]!)
    }

    @IBAction func forward() {
        month += 2
        if month > 12  {
            year += 1
            month = 1
        }
        period = String(format: "%03d%02d", year, month)
        dateLab.text = String(format: "%d年%@月", year, dic[month]!)
    }
    
    @IBAction func chooseDate(_ sender:UITapGestureRecognizer) {
        yearAD = year + 1911
        let selection = BillDateSelectionVC.dateSelectionController(.THREEDATE, withYear: Int32(yearAD), withMonth: Int32(month), endDay: Int32(day), hour: 11, minute: 30)
        selection?.frankSelection3Block = { [self](vc, dateAry) in
            let y = dateAry![0] as! String
            let m = dateAry![1] as! String
            let d = dateAry![2] as! String
            let tmp:String = String(format: "%@-%@-%@", y, m, d)
            let tmp2 = tmp.replacingOccurrences(of: "年", with: "")
            let tmp3 = tmp2.replacingOccurrences(of: "月", with: "")
            let rc = tmp3.replacingOccurrences(of: "日", with: "")
            self.dateLab2.text = rc
            self.dateLab2.textColor = .black
            self.checkField()
            
            let tmpy = y.replacingOccurrences(of: "年", with: "")
            let tmpm = m.replacingOccurrences(of: "月", with: "")
            let y_convert = Int(tmpy)! - 1911
            self.dateLab.text = String(format: "%d年%@月", y_convert, self.dic[Int(tmpm)!]!)
        }
        selection?.cancelButtonAction = { vc in
            
        }
        
        selection?.show(in: self, withTarget: selection)
    }
}
