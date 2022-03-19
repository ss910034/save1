//
//  ProductDetailViewController.swift
//  save
//
//  Created by Frank Liu on 2021/10/23.
//

import UIKit
import Kingfisher

var isToDetail = false

class ProdutCateDetailData: NSObject {
    var id:String = ""
    var merchantx:String = ""
    var catx:String = ""
    var barcodex:String = ""
    var productx:String = ""
    var pricex:String = ""
    var discountx:String = ""
    var isCollect:String = ""
    var updateTime:String = ""
}

class ProductDetailViewController: ProductCategoryPageViewController {

    @IBOutlet var titleLab: UILabel!
    var titleString = ""
    var dataAry:[ProdutCateDetailData]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.titleLab.text = titleString;
        collection.register(LoveCell.nib, forCellWithReuseIdentifier: LoveCell.identifier)
        isToDetail = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        isToDetail = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        isToDetail = false
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataAry.count
    }
    
    override func back() {
        self.navigationController?.popViewController(animated: true)
        gNav1 = gNav
        isToDetail = false
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
        vc.parentVC = self
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
        cell.parentVC = self
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 4, left: 0, bottom: 4, right: 0)
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        return CGSize(width: collectionViewWidth/3, height: 192)
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

}
