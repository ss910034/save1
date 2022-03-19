//
//  ProductDetailViewController.swift
//  save
//
//  Created by Frank Liu on 2021/10/23.
//

import UIKit
import SwiftyJSON

class ProductInfoViewController: BaseViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var myTableView: UITableView!
    @IBOutlet weak var productImg: UIImageView!
    @IBOutlet weak var loveImg: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var lastUpdate: UILabel!
    
    var productId = ""
    var selectedRow = 0
    var dataAry:[ProdutCateDetailData] = []
    var parentVC:ProductDetailViewController? = nil
    var parentVC2:ScanProductViewController? = nil
    var parentVC3:SellDetailViewController? = nil
    var parentVC4:SellDetailViewController? = nil
    var parentVC5:Tap3ViewController? = nil
    var entryType = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        self.myTableView.register(ProductDetailTableViewCell.nib, forCellReuseIdentifier: ProductDetailTableViewCell.identifier)
        let data = dataAry.first { product in
            productId == product.id
        }
        self.productImg.kf.setImage(with: URL(string: IMAGE_URL + data!.barcodex + ".png"), options:[.transition(.fade(0.6)), .cacheOriginalImage])
        if data!.isCollect == "1" {
            loveImg.image = UIImage(named: "largelovelove")
        }
        else {
            loveImg.image = UIImage(named: "largeloveempty")
        }
        name.text = data?.productx
        let date = Constants.getDateFromString(date: data!.updateTime)
        if date != nil {
            let comp = Constants.getDateComps(date: date!)
            lastUpdate.text = "最後更新：" + String(Int(comp.year!)) + "/" +  String(Int(comp.month!)) + "/" + String(Int(comp.day!))
        }
        else {
            lastUpdate.text = "API無回傳"
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isToDetail = true
    }
    
    @IBAction func doLove(_ sender:UITapGestureRecognizer) {
        let data = dataAry.first { product in
            productId == product.id
        }
        let status = (data?.isCollect == "1") ? "0" : "1"
        APIManager.shared.doLoveAction(isShow: true, barCode: data!.barcodex, isLove: status) { sta, JSON in
            let json:JSON! = JSON
            if json["status"] == "1" {
                if status == "1" {
                    self.loveImg.image = UIImage(named: "lovelove")
                }
                else {
                    self.loveImg.image = UIImage(named: "loveempty")
                }
                if let vc = self.parentVC {
                    vc.refreshData2(row: self.selectedRow, isLove: status)
                }
                if let vc = self.parentVC3 {
                    vc.refreshData2(row: self.selectedRow, isLove: status)
                }
                if let vc = self.parentVC4 {
                    vc.refreshData3(row: self.selectedRow, isLove: status)
                }
                if let vc = self.parentVC5 {
                    vc.refresh()
                }
            }
        }
    }
        
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let vc = parentVC2 {
            vc.reStartScan()
        }
        isToDetail = false
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataAry.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProductDetailTableViewCell.identifier, for: indexPath) as! ProductDetailTableViewCell
        
        let data:ProdutCateDetailData = dataAry[indexPath.row]
        cell.name.text = data.merchantx
        cell.price.text = data.pricex
        cell.activity.text = data.discountx
        return cell
    }
    
}
