//
//  Tap1ViewController.swift
//  save
//
//  Created by Frank Liu on 2021/10/21.
//

import UIKit

class Tap5ViewController: BaseViewController {

    @IBOutlet weak var here: UIImageView!
    @IBOutlet weak var name: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        isToDetail = false
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        here.image = UIImage(named: String(format: "h%d%d", gHereIndex, gHereIndex))
        if gHereIndex == 1 {
            name.text = "LV.4  失走男童"
        }
        else if gHereIndex == 2 {
            name.text = "LV.4  暴怒阿公"
        }
        else {
            name.text = "LV.4  瑜伽小姊姊"
        }
        self.tabBarController?.tabBar.isHidden = false
    }
    
    @IBAction func chooseConsume(_ sender:UITapGestureRecognizer) {
        let vc = ConsumeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func chooseHere(_ sender:UITapGestureRecognizer) {
        let vc = HereViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func chooseCoupon(_ sender:UITapGestureRecognizer) {
        let vc = CouponViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func choosePutCode(_ sender:UITapGestureRecognizer) {
        let vc = PutCodeViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func user(_ sender:UITapGestureRecognizer) {
        let vc = UserViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
