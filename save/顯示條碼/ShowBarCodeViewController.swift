//
//  ShowBarCodeViewController.swift
//  save
//
//  Created by Frank Liu on 2021/11/12.
//

import UIKit

var gIsBack = false

var gIsFromScan = 0

class ShowBarCodeViewController: UIViewController {

    @IBOutlet var lab: UILabel!
    var rotateType = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.lab.text = "/EJKK44Q"
        navigationController?.isNavigationBarHidden = true
        if self.tabBarController == nil, self.tabBarController?.tabBar.isHidden == true {
        }
        else {
            self.tabBarController?.tabBar.isHidden = true
//            gTapBarController1?.tabBar.isHidden = true
//            gTapBarController2?.tabBar.isHidden = true
//            gTapBarController3?.tabBar.isHidden = true
       }
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        if UIDevice.current.orientation.isLandscape {
            print("Landscape")
            switch UIDevice.current.orientation{
               case .landscapeLeft:
                print("Landscape Left")
               case .landscapeRight:
                print("Landscape Right")
               default:
                break
            }
        } else {
            self.back()
            print("Portrait")
        }
    }
    
    func back() {
        gIsBack = false
        if self.tabBarController == nil, self.tabBarController?.tabBar.isHidden == true {

        }
        else {
           self.tabBarController?.tabBar.isHidden = false
//            gTapBarController1?.tabBar.isHidden = false
//            gTapBarController2?.tabBar.isHidden = false
//            gTapBarController3?.tabBar.isHidden = false
        }
        if rotateType == 1 {
            self.dismiss(animated: true, completion: nil)
        }
        else {
            // gNav1?.popViewController(animated: true)
            self.navigationController?.popViewController(animated: true)
        }
        
        if gIsFromScan == 2 {
            gIsFromScan = 0
            gScan1 = 0
            gScan2 = 0
            NotificationCenter.default.post(name: NSNotification.Name("ScanProduct"), object: nil)
        }
        
        if gIsFromScan == 3 {
            gIsFromScan = 0
            gScan1 = 0
            gScan2 = 0
            NotificationCenter.default.post(name: NSNotification.Name("ScanInvoice"), object: nil)
        }
    }

    @IBAction func showMyCode(_ sender:UIButton) {
        self.lab.text = "/EJKK44Q"

        sender.setBackgroundImage(UIImage(named: "codeBtn12"), for: .normal)
        let btn:UIButton! = (self.view.viewWithTag(102) as! UIButton)
        btn.setBackgroundImage(UIImage(named: "codeBtn21"), for: .normal)
    }
    
    @IBAction func Donnet(_ sender:UIButton) {
        self.lab.text = "(雷射協會)台灣雷射應用發展協會"
        sender.setBackgroundImage(UIImage(named: "codeBtn22"), for: .normal)
        let btn:UIButton! = (self.view.viewWithTag(101) as! UIButton)
        btn.setBackgroundImage(UIImage(named: "codeBtn11"), for: .normal)
    }
}
