//
//  ActivityPageViewController.swift
//  HereHearV2
//
//  Created by Frank Liu on 2020/5/6.
//  Copyright © 2020 Frank Liu. All rights reserved.
//

import UIKit
import SwiftyJSON
import AVFoundation

class ProductCategoryPageViewController : BaseViewController,  UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    @IBOutlet var collection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collection.register(ProductCell.nib, forCellWithReuseIdentifier: ProductCell.identifier)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCell.identifier, for: indexPath) as! ProductCell
        
        cell.imgView.image = UIImage(named: String(format: "p%d", indexPath.row+1))

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        APIManager.shared.queryProductCagegory(isShow: true, name: produtCateDic[indexPath.row]!) { status, JSON in
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
            let vc = ProductDetailViewController()
            vc.titleString = produtCateDic[indexPath.row]!
            vc.dataAry = ary
            gNav2?.pushViewController(vc, animated: true);
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        return CGSize(width: collectionViewWidth/3, height: collectionViewWidth/3)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}
