//
//  FeedsViewController.swift
//  save
//
//  Created by Frank Liu on 2021/10/25.
//

import UIKit

class FeedsViewController: BaseViewController {

    @IBOutlet weak var labInvoice: UILabel!
    var strInvoice: String!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.labInvoice.text = strInvoice
    }
    
    @IBAction func sendMail() {
        Constants.showInfoDialog(vc: gRootViewController, title: "提示", content: "謝謝您的寶貴意見，我們將在3~5個工作天回覆您！", type: 0, isClose: 1)
    }

}
