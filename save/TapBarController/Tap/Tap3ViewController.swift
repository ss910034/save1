//
//  Tap1ViewController.swift
//  save
//
//  Created by Frank Liu on 2021/10/21.
//

import UIKit
import SwiftyJSON
import Kingfisher

class Tap3ViewController: ProductCategoryPageViewController {

    var dataAry:[ProdutCateDetailData]=[]

    override func viewDidLoad() {
        // super.viewDidLoad()
        collection.register(LoveCell.nib, forCellWithReuseIdentifier: LoveCell.identifier)
        isToDetail = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        refresh()
    }
    
    func refresh() {
        dataAry.removeAll()
        APIManager.shared.getLoveList(isShow: true) { Status, JSON in
            let json:JSON! = JSON
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
                data.productx = dic["productx"]!.stringValue
                data.isCollect = "1"
                if dic["updateTime"] != nil {
                    data.updateTime = dic["updateTime"]!.stringValue
                }
                else {
                    data.updateTime = ""
                }
                self.dataAry.append(data)
            }
            self.collection.delegate = self
            self.collection.dataSource = self
            self.collection.reloadData()
        }
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataAry.count
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let data = dataAry[indexPath.row]
        let ary = dataAry.filter { product in
            product.productx == data.productx
        }
        let vc = ProductInfoViewController()
        vc.dataAry = ary
        vc.productId = data.id
        vc.parentVC5 = self
        vc.selectedRow = indexPath.row
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoveCell.identifier, for: indexPath) as! LoveCell
        
        let data = dataAry[indexPath.row]
        cell.productPic.kf.setImage(with: URL(string: IMAGE_URL + data.barcodex + ".png"), options:[.transition(.fade(0.6)), .cacheOriginalImage])
        cell.loveimg.image = UIImage(named: "lovelove")
        cell.price.text = "$" + data.pricex
        cell.text.text = data.productx
        cell.data = data
        cell.parentVC2 = self
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        return CGSize(width: collectionViewWidth/3, height: 192)
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
    }


}
