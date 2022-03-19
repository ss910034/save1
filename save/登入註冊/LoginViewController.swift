//
//  LoginHomeViewController.swift
//  save
//
//  Created by Frank Liu on 2021/10/21.
//

import UIKit
import AVFoundation
import SwiftyJSON

var gNav:UINavigationController?=nil

var gPhoneNo = ""

class LoginViewController: BaseViewController {

    @IBOutlet weak var field1: UITextField!
    @IBOutlet weak var field2: UITextField!
    @IBOutlet weak var field3: UITextField!

    override func viewDidLoad() {
        // super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        #if DEBUG
        self.field1.text = "0918587059"
        self.field2.text = "gn831116@gmail.com"
        self.field3.text = "0918587059"
        gPhoneNo = self.field1.text!
        #endif
        gNav = self.navigationController
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKey(_:)))
        self.view.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)       // Or to rotate and lock
       // AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
       
   }

   override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       
       // Don't forget to reset when view is being removed
       AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.all)
   }
    
    @objc func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                self.view.frame.origin.y -= 200
            }
        }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification) {
        if view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    @objc func dismissKey(_ sender: UITapGestureRecognizer) {
        field1.resignFirstResponder()
        field2.resignFirstResponder()
        field3.resignFirstResponder()
    }
    
    @IBAction func login() {
        APIManager.shared.login(isShow: true, phone: field1.text!, email: field2.text!, password: field3.text!) { Status, JSON in
            let json:JSON! = JSON
            if json["status"].intValue == 1 {
                Constants.setLoginData(data: ["phone" : self.field1.text!, "email" : self.field2.text!, "password" : self.field3.text!])
                AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.all)
                let vc = TabHomeTableViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else {
                Constants.showInfoDialog(vc: self, title: "提示", content: "登入失敗！", type: 1, isClose: 0)
            }
        }
//        let vc = TabHomeTableViewController()
//        self.navigationController?.pushViewController(vc, animated: true)
    }
}
