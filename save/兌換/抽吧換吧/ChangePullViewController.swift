//
//  ChangePullViewController.swift
//  save
//
//  Created by Frank Liu on 2021/10/24.
//

import UIKit

class ChangePullViewController: BaseViewController {

    @IBOutlet weak var changeLab: UILabel!
    var type = 0
    var tmpTry = 0 // have to remove
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if type == 1 {
            self.changeLab.text = "換吧換吧"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func back() {
        self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func doAction(_ sender:UITapGestureRecognizer) {
        if tmpTry == 0 {
            let vc = InfoDialogViewController()
            vc.titleString = "提示"
            vc.contentString = "錢幣不足！"
            vc.type = type
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: false, completion: nil)
        }
        else if tmpTry == 1 {
            let vc = confirmDialogViewController()
            vc.titleString = "提示"
            vc.contentString = "使用10000$省幣？"
            vc.type = 0
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: false, completion: nil)
        }
        else if tmpTry == 2 {
            let vc = picDialogViewController()
            vc.titleString = "提示"
            vc.contentString = "兌換成功！在個人-兌換卷兌換。"
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: false, completion: nil)
        }
        else if tmpTry == 3 {
            let vc = countDialogViewController()
            vc.titleString = "提示"
            vc.contentString = "抽獎次數"
            vc.modalPresentationStyle = .overCurrentContext
            self.present(vc, animated: false, completion: nil)
        }
    }

}
