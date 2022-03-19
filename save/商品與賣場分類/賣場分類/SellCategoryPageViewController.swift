//
//  ActivityPageViewController.swift
//  HereHearV2
//
//  Created by Frank Liu on 2020/5/6.
//  Copyright © 2020 Frank Liu. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher


class SellCategoryPageViewController : ProductCategoryPageViewController {
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        var merch = ""
        if indexPath.row == 0 {
            merch = "全聯"
        }
        else if indexPath.row == 1 {
            merch = "美廉社"
        }
        else if indexPath.row == 2 {
            merch = "統一超商"
        }
        else if indexPath.row == 3 {
            merch = "全家"
        }
        else if indexPath.row == 4 {
            merch = "康是美"
        }
        else if indexPath.row == 5 {
            merch = "萊爾富"
        }
        else if indexPath.row == 6 {
            merch = "OK"
        }
        else if indexPath.row == 7 {
            merch = "家樂福"
        }
        else if indexPath.row == 8 {
            merch = "大潤發"
        }
        else if indexPath.row == 9 {
            merch = "tomods"
        }
        else if indexPath.row == 10 {
            merch = "頂好"
        }
        else if indexPath.row == 12 {
            merch = "愛買"
        }
        APIManager.shared.queryProductByMerch(isShow: true, merchant: merch) { status, JSON in
            let json:JSON! = JSON
            var ary:[ProdutCateDetailData] = []
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
                data.updateTime = dic["updateTime"]!.stringValue
                ary.append(data)
            }
            let vc = SellDetailViewController()
            vc.titleString = merch
            vc.dataAry = ary
            gNav2?.pushViewController(vc, animated: true);
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        return CGSize(width: collectionViewWidth/2, height: collectionViewWidth/2)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath) as! ProductCell
        cell.imgView.image = UIImage(named: String(format: "s%d", indexPath.row+1))
        return cell
    }

}
