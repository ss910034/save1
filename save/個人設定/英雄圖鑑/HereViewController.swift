//
//  HereViewController.swift
//  save
//
//  Created by Frank Liu on 2021/10/24.
//

import UIKit

var gHereIndex = 1

class HereViewController: ProductCategoryPageViewController {

    override func viewDidLoad() {
        // super.viewDidLoad()
        collection.register(HereCell.nib, forCellWithReuseIdentifier: HereCell.identifier)
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
        self.navigationController?.popViewController(animated: true)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HereCell.identifier, for: indexPath) as! HereCell
        
        cell.imgView.image = UIImage(named: String(format: "h%d", indexPath.row+1))

        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionViewWidth = collectionView.bounds.width
        return CGSize(width: collectionViewWidth/2, height: collectionViewWidth/2)
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        gHereIndex = indexPath.row + 1
        super.back()
    }

}
