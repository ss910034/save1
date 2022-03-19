//
//  ProductDetailViewController.swift
//  save
//
//  Created by Frank Liu on 2021/10/23.
//

import UIKit
import SwiftyJSON

class SellDetailViewController: ProductCategoryPageViewController, KPDropMenuDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var titleLab: UILabel!
    var titleString = ""
    @IBOutlet var _drop: KPDropMenu!
    @IBOutlet var darkView: UIView!
    @IBOutlet var myTableView: UITableView!
    var state = 0
    var dataAry:[ProdutCateDetailData]=[]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLab.text = titleString;
        collection.register(LoveCell.nib, forCellWithReuseIdentifier: LoveCell.identifier)
        self.myTableView.register(SellCellTableViewCell.nib, forCellReuseIdentifier: SellCellTableViewCell.identifier)
        
        var ary:[String] = []
        var aryId:[String] = []
        ary.append("顯示全部")
        aryId.append("0")
        
        for i in 0..<produtCateDic.count {
            ary.append("    " + produtCateDic[i]!)
            aryId.append(String(i+1))
        }
//        for (key, value) in produtCateDic {
//            ary.append("    " + value)
//            aryId.append(String(key+1))
//        }
//        _drop.items = ["顯示全部", "    Apple", "   Grapes", "  Cherry", "  Pineapple", "   Mango", "   Orange"]
//        _drop.itemsIDs = ["0", "1", "2", "3", "4", "5"];
        _drop.items = ary
        _drop.itemsIDs = aryId
        _drop.itemsFont = UIFont.systemFont(ofSize: 12.0)
        _drop.title = "    顯示全部"
        _drop.titleTextAlignment = .left;
        _drop.itemTextAlignment = .left;
        _drop.delegate = self;
        
        state = 0
        isToDetail = true
    }
    
    @IBAction func changeMenu(_ sender: UIButton) {
        if state == 0 {
            sender.setImage(UIImage(named:"dropmenu2"), for: .normal)
            state = 1
            collection.isHidden = true
            myTableView.isHidden = false
            myTableView.reloadData()
         }
        else{
            sender.setImage( UIImage(named:"dropmenu"), for: .normal)
            state = 0
            collection.isHidden = false
            myTableView.isHidden = true
            collection.reloadData()
         }
    }
    
    override func back() {
        // self.parent?.parent?.navigationController?.popViewController(animated: true)
        self.navigationController?.popViewController(animated: true)
        gNav1 = gNav
        isToDetail = false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 165.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataAry.count
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
        if date != nil {
            let comp = Constants.getDateComps(date: date!)
            cell.desc2.text = "最後更新：" + String(Int(comp.year!)) + "/" +  String(Int(comp.month!)) + "/" + String(Int(comp.day!))
        }
        cell.data = data
        cell.selectedRow = indexPath.row
        cell.parentVC = self
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataAry.count
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let data = dataAry[indexPath.row]
        let ary = dataAry.filter { product in
            product.productx == data.productx
        }
        let vc = ProductInfoViewController()
        vc.dataAry = ary
        vc.productId = data.id
        vc.parentVC3 = self
        vc.selectedRow = indexPath.row
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoveCell.identifier, for: indexPath) as! LoveCell
        
        let data = dataAry[indexPath.row]
        cell.productPic.kf.setImage(with: URL(string: IMAGE_URL + data.barcodex + ".png"), options:[.transition(.fade(0.6)), .cacheOriginalImage])
        if data.isCollect == "1" {
            cell.loveimg.image = UIImage(named: "lovelove")
        }
        else {
            cell.loveimg.image = UIImage(named: "loveempty")
        }
        cell.price.text = "$" + data.pricex
        cell.text.text = data.productx
        cell.data = data
        cell.selectedRow = indexPath.row
        cell.parentVC3 = self
        
        return cell
    }
    
    func refreshData(row:Int, isLove:String) {
        let data = self.dataAry[row]
        data.isCollect = isLove
        self.dataAry[row] = data
    }
    
    func refreshData2(row:Int, isLove:String) {
        let data = self.dataAry[row]
        data.isCollect = isLove
        self.dataAry[row] = data
        self.collection.reloadItems(at: [IndexPath(item: row, section: 0)])
    }
    
    func refreshData3(row:Int, isLove:String) {
        let data = self.dataAry[row]
        data.isCollect = isLove
        self.dataAry[row] = data
        self.myTableView.reloadRows(at: [IndexPath(row: row, section: 0)], with: .automatic)
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        return CGSize(width: collectionViewWidth/3, height: 192)
    }
    
    func didSelectItem(_ dropMenu: KPDropMenu!, at atIndex: Int32) {
        print(atIndex)
        if atIndex == 0 {
            APIManager.shared.queryProductByMerch(isShow: true, merchant: titleString) { state, JSON in
                let json:JSON! = JSON
                var ary:[ProdutCateDetailData] = []
                self.dataAry.removeAll()
                let dic = json.dictionaryValue.sorted(by: { $0 < $1})
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
                    ary.append(data)
                }
                self.dataAry = ary
                if self.state == 1 {
                    self.myTableView.reloadData()
                }
                else {
                    self.collection.reloadData()
                }
            }
            return
        }
        let cate = produtCateDic[Int(atIndex-1)]
        APIManager.shared.queryProductByMerchAndSeller(isShow: true, merchantx: titleString, catx: cate!) { state, JSON in
            let json:JSON! = JSON
            var ary:[ProdutCateDetailData] = []
            self.dataAry.removeAll()
            let dic = json.dictionaryValue.sorted(by: { $0 < $1})
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
                ary.append(data)
            }
            self.dataAry = ary
            if self.state == 1 {
                self.myTableView.reloadData()
            }
            else {
                self.collection.reloadData()
            }
        }
    }
    
    func didShow(_ dropMenu: KPDropMenu!) {
        self.darkView.isHidden = false
    }
    
    func didHide(_ dropMenu: KPDropMenu!) {
        self.darkView.isHidden = true
    }
}
