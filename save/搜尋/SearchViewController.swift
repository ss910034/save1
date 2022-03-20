//
//  SearchViewController.swift
//  save
//
//  Created by Frank Liu on 2021/10/23.
//

import UIKit
import iOSDropDown
import SwiftyJSON

class SearchViewController: SellDetailViewController {

    @IBOutlet weak var dropDown : UITextField!
    @IBOutlet weak var notfound : UIImageView!
    @IBOutlet var myTableView2 : UITableView!
    @IBOutlet var h : NSLayoutConstraint!
    var dataAry2:[String]=[]
    var ary:[String]? = Constants.getHistorySearchData() ?? []
    var statusMode = 0 //0:show more 1:all
    
    override func viewDidLoad() {
        // super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        if let ary = ary {
            dataAry2 = ary
            myTableView2.reloadData()
            setSearchTableHeight()
        }
        else {
            myTableView2.isHidden = true
        }
        
        self.myTableView.register(SellCellTableViewCell.nib, forCellReuseIdentifier: SellCellTableViewCell.identifier)
        self.myTableView.isHidden = true
        dropDown.becomeFirstResponder()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // self.tabBarController?.tabBar.isHidden = false
    }
    
    override func back() {
        gScan1 = 0
        gScan2 = 0
        self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
        NotificationCenter.default.post(name: NSNotification.Name("ScanProduct"), object: nil)
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.notfound.isHidden = true
        if dataAry2.count == 0 {
            myTableView2.isHidden = true
            return
        }
        myTableView2.isHidden = false
        setSearchTableHeight()
        self.view.bringSubviewToFront(myTableView2)
    }
    
    @IBAction func doSearch(_ sender: UIButton) {
        dropDown.resignFirstResponder()
        if dropDown.text != "" {
            APIManager.shared.queryProductByName(isShow: true, name: dropDown.text!) { status, JSON in
                let json:JSON! = JSON
                if json.dictionaryValue.count == 0 {
                    self.myTableView.isHidden = true
                    self.notfound.isHidden = false
                    self.myTableView2.isHidden = true
                    self.updateDropMenu()
                    self.notfound.isHidden = false
                    return
                }
                var ary:[ProdutCateDetailData] = []
                let dic = json.dictionaryValue.sorted(by: { $0 < $1})
                self.notfound.isHidden = true
                dic.forEach { (key: String, value: JSON) in
                    let data = ProdutCateDetailData()
                    let dic = value.dictionaryValue
                    data.id = dic["id"]!.stringValue
                    data.discountx = dic["discountx"]!.stringValue
                    data.productx = dic["productx"]!.stringValue
                    data.pricex = dic["pricex"]!.stringValue
                    data.barcodex = dic["barcodex"]!.stringValue
                    data.merchantx = dic["merchantx"]!.stringValue
                    data.catx = dic["catx"]!.stringValue
                    data.isCollect = dic["isCollect"]!.stringValue
                    data.productx = dic["productx"]!.stringValue
                    data.updateTime = dic["updateTime"]!.stringValue
                    ary.append(data)
                }
                self.myTableView.isHidden = false
                self.notfound.isHidden = true
                self.myTableView2.isHidden = true
                self.view.bringSubviewToFront(self.myTableView)
                self.dataAry = ary
                self.updateDropMenu()
                self.myTableView.reloadData()
            }
        }
        else {
            self.myTableView.isHidden = true
            self.notfound.isHidden = false
            self.myTableView2.isHidden = true
        }
    }
    
    func setSearchTableHeight() {
        if statusMode == 0 {
            if dataAry2.count <= 6 {
                h.constant = CGFloat((dataAry2.count + 1) * 40)
            }
            else {
                h.constant = CGFloat(7 * 40)
            }
        }
        else {
            h.constant = CGFloat((dataAry2.count + 1) * 40)
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == myTableView {
            return super.tableView(tableView, heightForRowAt: indexPath)
        }
        else {
            return 40.0
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == myTableView {
            return super.tableView(tableView, numberOfRowsInSection: section)
        }
        else {
            return dataAry2.count + 1
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if tableView == myTableView {
            let data = dataAry[indexPath.row]
            let ary = dataAry.filter { product in
                product.productx == data.productx
            }
            let vc = ProductInfoViewController()
            vc.dataAry = ary
            vc.productId = data.id
            vc.parentVC4 = self
            vc.selectedRow = indexPath.row
            gNav?.pushViewController(vc, animated: true)
        }
        else {
            let cell = myTableView2.cellForRow(at: indexPath)
            if cell?.textLabel?.text == "清除歷史資料"{
                ary?.removeAll()
                dataAry2 = ary!
                myTableView2.reloadData()
                myTableView2.isHidden = true
                statusMode = 0
                Constants.clearHistorySearchData()
            }
            else if cell?.textLabel?.text == "顯示更多"{
                myTableView2.reloadData()
                statusMode = 1
                setSearchTableHeight()
            }
            else{
                let char = (cell?.textLabel?.text)!
                let char1 = String(char.dropFirst().dropFirst().dropFirst())
                self.dropDown.text = char1
                self.myTableView2.isHidden = true
                self.doSearch(UIButton())
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == myTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: SellCellTableViewCell.identifier, for: indexPath) as! SellCellTableViewCell
            
            let data = dataAry[indexPath.row]
            cell.pic.kf.setImage(with: URL(string: IMAGE_URL + data.barcodex + ".png"), options:[.transition(.fade(0.6)), .cacheOriginalImage])
            if data.isCollect == "1" {
                cell.love.image = UIImage(named: "lovelove")
            }
            else {
                cell.love.image = UIImage(named: "loveempty")
            }
            cell.price.text = "$" + data.pricex
            cell.desc1.text = data.productx
            let date = Constants.getDateFromString(date: data.updateTime)
            let comp = Constants.getDateComps(date: date!)
            cell.desc2.text = "最後更新：" + String(Int(comp.year!)) + "/" +  String(Int(comp.month!)) + "/" + String(Int(comp.day!))
            cell.data = data
            cell.selectedRow = indexPath.row
            cell.parentVC = self
            return cell
        }
        else {
            let cellIdentifier = "Cell"
            var cell: UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
            }

            if dataAry2.count > 6{
                if indexPath.row < 6{
                    cell?.textLabel?.text = "   " + dataAry2[indexPath.row]
                    cell?.textLabel?.textAlignment = .left
                }
                else{
                    if statusMode == 1{
                        if indexPath.row == dataAry2.count{
                            cell?.textLabel?.text = "清除歷史資料"
                            cell?.textLabel?.textAlignment = .center
                        }
                        else{
                            cell?.textLabel?.text = "   " + dataAry2[indexPath.row]
                            cell?.textLabel?.textAlignment = .left
                        }
                    }
                    else{
                        cell?.textLabel?.text = "顯示更多"
                        cell?.textLabel?.textAlignment = .center
                    }
                }
            }
            else{
                if indexPath.row == dataAry2.count{
                    cell?.textLabel?.text = "清除歷史資料"
                    cell?.textLabel?.textAlignment = .center
                }
                else{
                    cell?.textLabel?.text = "   " + dataAry2[indexPath.row]
                    cell?.textLabel?.textAlignment = .left
                }
            }
            cell?.textLabel?.textColor = .gray
            return cell!
        }
    }
    
    override func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        doSearch(UIButton())
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func dismissKeyboard(_ sender:UITapGestureRecognizer) {
        dropDown.resignFirstResponder()
    }
    
    func updateDropMenu() {
        var f = false
        if let ary = ary {
            if dropDown.text != ""{
                let txt = dropDown.text!
                if ary.contains(txt){
                    f = true
                }
            }
        }

        if f == false {
            ary!.insert(dropDown.text!, at: 0)
            dataAry2 = ary!
            myTableView2.reloadData()
            setSearchTableHeight()
            Constants.setHistorySearchData(data: ary!)
        }
    }
}
