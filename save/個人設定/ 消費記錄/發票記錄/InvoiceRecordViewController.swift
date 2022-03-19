//
//  InvoiceRecordViewController.swift
//  save
//
//  Created by Frank Liu on 2021/10/25.
//

import UIKit
import SwiftyJSON

class InvoiceData: NSObject {
    var invNum:String = ""
    var invDate:String = ""
    var invPeriod:String = ""
    var sellerName:String = ""
    var sellerAddress:String = ""
    var amount:String = ""
    var prizeStatus:String = ""
    var prizeType:String = ""
    var prizeMoney:String = ""
    var cardNo:String = ""
}

class InvoiceDetail: NSObject {
    var desc:String = ""
    var quantity:String = ""
    var unitPrice:String = ""
    var amount:String = ""
}

var gInvTotalCount = 0
var gInvTotalBingo = 0
var gInvTotalBingoMoney = 0
var gInvBingStatus = ""

var gInvInfoDic:[Int : [Any]] = [0 : [],
                                 1 : [],
                                 2 : [],
                                 3 : [],
                                 4 : [],
                                 5 : []]

class InvoiceRecordViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var counts: UILabel!
    @IBOutlet weak var total: UILabel!

    let periodDic:[Int:String] = [0 : "1-2",
                                  1 : "3-4",
                                  2 : "5-6",
                                  3 : "7-8",
                                  4 : "9-10",
                                  5 : "11-12"]
    
    var selectedIndex = 0
    
    var dataAry:[InvoiceData] = []
    var totalCounts = 0
    var totalMoney = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTableView.register(InvoiceRecordTableViewCell.nib, forCellReuseIdentifier: InvoiceRecordTableViewCell.identifier)
        
        self.myTableView.backgroundColor = .clear
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //collection.reloadData()
        NotificationCenter.default.addObserver(self, selector: #selector(changePage(_:)), name: NSNotification.Name("ChangeInvoicePage"), object: nil)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func changePage(_ notification: NSNotification) {
        let dic = notification.userInfo
        self.selectedIndex = dic!["index"] as! Int
        refresh()
    }
    
    func refresh() {
        self.myTableView.delegate = nil
        self.myTableView.dataSource = nil
        self.dataAry.removeAll()
        totalCounts = 0
        totalMoney = 0
        gInvTotalCount = 0
        gInvTotalBingo = 0
        gInvTotalBingoMoney = 0
        gInvBingStatus = ""
        gInvTotalCount = self.totalCounts
        let ary2 = [self.totalCounts, gInvTotalBingo, gInvTotalBingoMoney, gInvBingStatus] as [Any]
        gInvInfoDic[self.selectedIndex] = ary2
        APIManager.shared.queryInvoiceList(isShow: true, queryMon: periodDic[selectedIndex]!) { status, JSON in
            let json:JSON! = JSON
            var ary:[InvoiceData] = []
            if json.dictionaryValue.count == 0 {
                self.myTableView.separatorStyle = .none
                self.myTableView.delegate = self
                self.myTableView.dataSource = self
                self.myTableView.reloadData()
                self.counts.text = "0"
                self.total.text = "0"
                return
            }
            let dic = json.dictionaryValue.sorted(by: { $0 < $1})
            var bingo = false
            var bingo2 = false
            dic.forEach { (key: String, value: JSON) in
                let data = InvoiceData()
                let dic = value.dictionaryValue
                data.invNum = dic["invNum"]!.stringValue
                data.invDate = dic["invDate"]!.stringValue
                data.invPeriod = dic["invPeriod"]!.stringValue
                data.sellerName = dic["sellerName"]!.stringValue
                data.sellerAddress = dic["sellerAddress"]!.stringValue
                data.amount = dic["amount"]!.stringValue
                data.prizeStatus = dic["prizeStatus"]!.stringValue
                data.prizeType = dic["prizeType"]!.stringValue
                data.prizeMoney = dic["prizeMoney"]!.stringValue
                data.cardNo = dic["cardNo"]!.stringValue
                ary.append(data)
                self.totalCounts += 1
                if data.amount != "" {
                    let d = Double(data.amount)!
                    self.totalMoney += Int(d)
                }
                gInvTotalBingoMoney += Int(data.prizeMoney == "" ? "0" : "0")!
                print("prizeStatus: " + data.prizeStatus)
                if data.prizeStatus == "0", !bingo, !bingo2 {
                    bingo2 = true
                    gInvBingStatus = "0"            // 未中獎
                }
                else if data.prizeStatus == "1", !bingo {
                    bingo = true
                    gInvBingStatus = "1"            // 中獎
                }
                else if data.prizeStatus == "9", !bingo, !bingo2 {
                    bingo2 = true
                    gInvBingStatus = "9"            // 尚未開獎
                }
            }
            gInvTotalCount = self.totalCounts
            let ary2 = [self.totalCounts, gInvTotalBingo, gInvTotalBingoMoney, gInvBingStatus] as [Any]
            gInvInfoDic[self.selectedIndex] = ary2
            self.counts.text = "\(self.totalCounts)"
            self.total.text = "\(self.totalMoney)"
            self.dataAry = ary.sorted { $0.invDate > $1.invDate }
            self.myTableView.delegate = self
            self.myTableView.dataSource = self
            self.myTableView.separatorStyle = .singleLine
            self.myTableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataAry.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let data:InvoiceData = self.dataAry[indexPath.row]
        APIManager.shared.queryInvoiceDetail(isShow: true, invoiceNum: data.invNum, invoiceDate: data.invDate) { status, JSON in
            let json:JSON! = JSON
            if json == nil {
                Constants.showInfoDialog(vc: gRootViewController, title: "提示", content: "資料錯誤", type: 1, isClose: 0)
                return
            }
            var ary:[InvoiceDetail] = []
            let invoice:InvoiceData = InvoiceData()
            invoice.invNum = json["invNum"].stringValue
            invoice.invDate = json["invDate"].stringValue
            invoice.invPeriod = json["invPeriod"].stringValue
            invoice.sellerName = json["sellerName"].stringValue
            invoice.sellerAddress = json["sellerAddress"].stringValue
            invoice.amount = json["amount"].stringValue
            let dic = json["details"].dictionaryValue.sorted(by: { $0 < $1})
            dic.forEach { (key: String, value: JSON) in
                let data = InvoiceDetail()
                let dic = value.dictionaryValue
                data.desc = dic["description"]!.stringValue
                data.quantity = dic["quantity"]!.stringValue
                data.amount = dic["amount"]!.stringValue
                data.unitPrice = dic["unitPrice"]!.stringValue
                ary.append(data)
            }
            let vc = VoiceDetailCardViewController()
            vc.invoiceData = invoice
            vc.invoiceDetailAry = ary
            if  data.cardNo == "" {
                vc.phoneCodeString = "紙本發票"
            }
            gRootViewController.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: InvoiceRecordTableViewCell.identifier, for: indexPath) as! InvoiceRecordTableViewCell
        let data:InvoiceData = self.dataAry[indexPath.row]
        cell.date.text = data.invDate
        cell.desc.text = data.sellerName
        cell.money.text = data.amount
        cell.dollarImg.isHidden = (data.prizeStatus == "1") ? false : true
        cell.tool.text = data.cardNo
        //
        if data.cardNo != "" {
            cell.tool.text = data.cardNo + " " + "手機條碼"
        }

        return cell
    }

}
