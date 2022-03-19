//
//  Tap1ViewController.swift
//  save
//
//  Created by Frank Liu on 2021/10/21.
//

import UIKit

class Tap4ViewController: ProductCategoryPageViewController {

    var fullScreenSize :CGSize! = UIScreen.main.bounds.size

    override func viewDidLoad() {
        isToDetail = false
        // super.viewDidLoad()
        collection.register(ChangeCell.nib, forCellWithReuseIdentifier: ChangeCell.identifier)
        // collection.register(ChangeHeaderTableViewCell.nib, forCellWithReuseIdentifier: ChangeHeaderTableViewCell.identifier)
        // collection.register(UINib(nibName: "ChangeHeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind:UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
        collection.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header")
    }
    
    @IBAction func record(_ sender:UITapGestureRecognizer) {
        let vc = ChangeRecordViewController()
        self.navigationController!.pushViewController(vc, animated: true)
    }
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        // 建立 UICollectionReusableView
//        var reusableView = UICollectionReusableView()
//
//        // 顯示文字
//        let label = UILabel(frame: CGRect(x: 0, y: 0, width: fullScreenSize.width, height: 40))
//        label.textAlignment = .center
//
//        // header
//        if kind == UICollectionView.elementKindSectionHeader && (indexPath.section == 0 || indexPath.section == 1) {
//            // 依據前面註冊設置的識別名稱 "Header" 取得目前使用的 header
//            reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header", for: indexPath)
//            // 設置 header 的內容
//            reusableView.backgroundColor = UIColor.darkGray
//            label.text = "Header";
//            label.textColor = UIColor.white
//            reusableView.addSubview(label)
//        }
//        else {
//            reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header", for: indexPath)
//            reusableView.frame = .zero
//        }
//
//        return reusableView
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSize(width:collectionView.frame.size.width, height:40)
        } else if section == 1 {
            return CGSize(width:collectionView.frame.size.width, height:40)
        }
        else {
            return CGSize.zero
        }
    }
//
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        var reusableView = UICollectionReusableView()
        let label = UILabel(frame: CGRect(x: 0+18, y: 0, width: 70, height: 40))
        label.textAlignment = .left
        let label2 = UILabel(frame: CGRect(x: 70+18, y: 2, width: 200, height: 40))
        label2.textAlignment = .left
        
        if (kind == UICollectionView.elementKindSectionHeader) {
            let section = indexPath.section
            switch (section) {
            case 0:
                fallthrough
            case 1:
                reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "Header", for: indexPath)
                // 設置 header 的內容
                reusableView.backgroundColor = UIColor.white
                label.text = "抽厚送";
                label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
                label.textColor = Constants.getDefaultTextColor()
                reusableView.addSubview(label)
                label2.text = "哪有那麼好康，省幣抽到爽！";
                label2.font = UIFont.systemFont(ofSize: 13)
                label2.textColor = Constants.getDefaultTextColor()
                reusableView.addSubview(label)
                reusableView.addSubview(label2)
            default:
                return reusableView
            }
        }
        return reusableView
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 || section == 1 {
            return 2
        }
        else {
            return 6
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let vc = ChangePullViewController()
        if indexPath.row == 0 {
            vc.type = 0
            vc.tmpTry = 0
        }
        else if indexPath.row == 1 {
            vc.type = 0
            vc.tmpTry = 1
        }
        else if indexPath.row == 2 {
            vc.type = 1
            vc.tmpTry = 0
        }
        else if indexPath.row == 3 {
            vc.tmpTry = 2
        }
        else if indexPath.row == 4 {
            vc.tmpTry = 3
        }
        self.navigationController!.pushViewController(vc, animated: true)
    }
    

    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        return CGSize(width: collectionViewWidth/2, height: 221)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ChangeCell.identifier, for: indexPath) as! ChangeCell

        if indexPath.section == 0  {
            cell.change.image = UIImage(named: "changepull")
            cell.money.text = "100元/次"
            cell.left.text = "下注:345x"
        }
        if indexPath.section == 1 {
            cell.change.image = UIImage(named: "changechange")
            cell.money.text = "10000"
            cell.left.text = "剩餘:4"
        }
        
        if indexPath.section == 2 && (indexPath.row == 0 || indexPath.row == 1) {
            cell.change.image = UIImage(named: "changechange")
            cell.productPic.image = UIImage(named: "changeicon2")
            if indexPath.row == 4 {
                cell.left.text = "下注:345"
                cell.money.text = "100/次"
            }
            else {
                cell.left.text = "剩餘:4"
                cell.money.text = "10000"
            }
        }
        
        if indexPath.section == 2 && (indexPath.row == 2 || indexPath.row == 3) {
            cell.change.image = UIImage(named: "changechange")
            cell.productPic.image = UIImage(named: "changeicon3")
            if indexPath.row == 6 {
                cell.left.text = "下注:345"
                cell.money.text = "100/次"
            }
            else {
                cell.left.text = "剩餘:4"
                cell.money.text = "10000"
            }
        }
        
        if indexPath.section == 2 && ( indexPath.row == 4 || indexPath.row == 5) {
            cell.change.image = UIImage(named: "changechange")
            cell.productPic.image = UIImage(named: "changeicon4")
            if indexPath.row == 8 {
                cell.left.text = "下注:345"
                cell.money.text = "100/次"
            }
            else {
                cell.left.text = "剩餘:4"
                cell.money.text = "10000"
            }
        }
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }

    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
