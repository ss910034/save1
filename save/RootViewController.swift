//
//  ViewController.swift
//  save
//
//  Created by Frank Liu on 2021/10/20.
//

import UIKit
import SwiftyJSON

var gRootViewController:UIViewController!

class RootViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        gRootViewController = self
        if Constants.isFirstEnter() {
            showWelcomePage()
        }
        else if let loginData = Constants.getLoginData() {
            autoLogin(phone: loginData["phone"]!, email: loginData["email"]!, pw: loginData["password"]!)
        }
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
    
    func autoLogin(phone:String, email:String, pw:String) {
        /*
        APIManager.shared.login(isShow: true, phone: phone, email: email, password: pw) { Status, JSON in
            let json:JSON! = JSON
            if json["status"].intValue == 1 {
                gPhoneNo = phone
                gNav = self.navigationController
                let vc = TabHomeTableViewController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            else {
                Constants.showInfoDialog(vc: self, title: "提示", content: "登入失敗！", type: 1, isClose: 0)
            }
        }
        */
        gPhoneNo = phone
        gNav = self.navigationController
        let vc = TabHomeTableViewController()
        self.navigationController?.pushViewController(vc, animated: false)
    }

    @objc func showWelcomePage() {
        let vc = WelcomePageViewController(nibName: WelcomePageViewController.identifier, bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func login() {
        let vc = LoginViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

