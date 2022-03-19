//
//  NewMemberCardViewController.swift
//  save
//
//  Created by Frank Liu on 2021/10/25.
//

import UIKit

class VoiceDetailCardViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var invNum: UILabel!
    @IBOutlet weak var addr: UILabel!
    @IBOutlet weak var companyCode: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var phoneCode: UILabel!

    var invoiceData:InvoiceData!
    var invoiceDetailAry:[InvoiceDetail] = []
    var total = 0
    var phoneCodeString = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTableView.register(InvoiceDetailTableViewCell.nib, forCellReuseIdentifier: InvoiceDetailTableViewCell.identifier)
        self.name.text = invoiceData.sellerName
        self.addr.text = invoiceData.sellerAddress == "" ? "無" : invoiceData.sellerAddress
        self.date.text = invoiceData.invDate
        self.invNum.text = invoiceData.invNum
        self.companyCode.text = "無"
        
        invoiceDetailAry.forEach { data in
            let a = Double(data.amount)!
            total += Int(a)
        }
        if self.date.text != "" && self.date.text!.count >= 8 {
            let y:String = self.date.text?.substring(with: 0..<4) ?? "0000"
            let m:String = self.date.text?.substring(with: 4..<6) ?? "00"
            let d:String = self.date.text?.substring(with: 6..<8) ?? "00"
            self.date.text = String(format: "%@-%@-%@", y, m, d)
        }
        else {
            self.date.text = String(format: "%@-%@-%@", "yyyy", "mm", "dd")
        }
        
        phoneCode.text = phoneCodeString
    }
    
    @IBAction func showFeed(_ sender:UITapGestureRecognizer) {
        let vc = FeedsViewController()
        vc.strInvoice = invNum.text
        gRootViewController.navigationController?.pushViewController(vc, animated: true)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return invoiceDetailAry.count + 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InvoiceDetailTableViewCell.identifier, for: indexPath) as! InvoiceDetailTableViewCell
        
        if indexPath.row <= invoiceDetailAry.count - 1 {
            let data = invoiceDetailAry[indexPath.row]
            cell.name.text = data.desc
            let u = Double(data.unitPrice)!
            let q = Double(data.quantity)!
            cell.price.text = "\(Int(u))" + " x " + "\(Int(q))"
            cell.total.text = data.amount
        }
        if indexPath.row == invoiceDetailAry.count {
            cell.price.isHidden = true
            cell.name.text = "合計"
            cell.total.text = "\(total)"
        }
        
        cell.selectionStyle = .none
        return cell
    }
    
//    @IBAction func scanMembar(_ sender:UITapGestureRecognizer) {
//        let vc = MemberScanCardViewController()
//        gRootViewController.navigationController?.pushViewController(vc, animated: true)
//    }
    
}
