//
//  ChangePullViewController.swift
//  save
//
//  Created by Frank Liu on 2021/10/24.
//

import UIKit

class BarCodeChangeViewController: BaseViewController {

    @IBOutlet weak var changeLab: UILabel!
    var type = 0
    var tmpTry = 0 // have to remove
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func doAction(_ sender:UITapGestureRecognizer) {
        let vc = barcodeDialogViewController()
        vc.titleString = "兌換條碼"
        vc.contentString = "62288798273981273"
        vc.modalPresentationStyle = .overCurrentContext
        gNav?.present(vc, animated: false, completion: nil)
    }

}
