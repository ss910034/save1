//
//  TabHomeTableViewController.swift
//  save
//
//  Created by Frank Liu on 2021/10/21.
//

import UIKit
import SwiftUI

class ProductTabHomeTableViewController: UITabBarController, UITabBarControllerDelegate {

    var titleString = ""
    var dataAry:[ProdutCateDetailData]=[]
    var nav1:UINavigationController? = nil
    var nav2:UINavigationController? = nil
    var nav3:UINavigationController? = nil
    var nav4:UINavigationController? = nil
    var nav5:UINavigationController? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        self.delegate = self
        gTapBarController2 = self
//        self.tabBar.isHidden = true
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //self.tabBar.isHidden = false
//        DispatchQueue.main.asyncAfter(deadline: .now()+0.5) {
//            self.tabBar.isHidden = false
//        }
        setTabBarView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        // self.tabBar.isHidden = false
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        addHeightConstraintToTabbar()
    }
    
    func addHeightConstraintToTabbar() -> Void {
        let heightConstant:CGFloat = self.view.safeAreaInsets.bottom + 49.0
        tabBarController?.tabBar.heightAnchor.constraint(equalToConstant: heightConstant).isActive = true
    }

    func setTabBarView()  {
//        tabBar.clipsToBounds = true
//        tabBar.backgroundImage = UIImage()
//        let bgView: UIImageView = UIImageView(image: UIImage(named: "tapbarbg"))
//        bgView.frame = tabBar.bounds
//        tabBar.addSubview(bgView)
        
        let tabOne = Tap1ViewController()
        nav1 = UINavigationController(rootViewController: tabOne)
        let tabOneBarItem = UITabBarItem(title: "", image: UIImage(named: "tap1"), selectedImage: UIImage(named: "tapd1"))
        tabOne.tabBarItem = tabOneBarItem
        nav1!.view.tag = 101
        gNav1 = nav1

        let tabTwo = ProductDetailViewController()
        nav2 = UINavigationController(rootViewController: tabTwo)
        tabTwo.titleString = titleString
        tabTwo.dataAry = dataAry
        let tabTwoBarItem = UITabBarItem(title: "", image: UIImage(named: "tap2"), selectedImage: UIImage(named: "tapd2"))
        tabTwo.tabBarItem = tabTwoBarItem
        nav2!.view.tag = 102
        gNav2 = nav2

        let tabThree = Tap3ViewController()
        nav3 = UINavigationController(rootViewController: tabThree)
        let tabThreeBarItem = UITabBarItem(title: "", image: UIImage(named: "tap3"), selectedImage: UIImage(named: "tapd3"))
        tabThree.tabBarItem = tabThreeBarItem
        nav3!.view.tag = 103

        let tabFour = Tap4ViewController()
        nav4 = UINavigationController(rootViewController: tabFour)
        let tabFourBarItem = UITabBarItem(title: "", image: UIImage(named: "tap4"), selectedImage: UIImage(named: "tapd4"))
        tabFour.tabBarItem = tabFourBarItem
        nav4!.view.tag = 104

        let tabFive = Tap5ViewController()
        nav5 = UINavigationController(rootViewController: tabFive)
        let tabFiveBarItem = UITabBarItem(title: "", image: UIImage(named: "tap5"), selectedImage: UIImage(named: "tapd5"))
        tabFive.tabBarItem = tabFiveBarItem
        nav5!.view.tag = 105

        self.viewControllers = [nav1!, nav2!, nav3!, nav4!, nav5!]
//        self.tabBar.clipsToBounds = true
//        self.tabBar.backgroundImage = UIImage()
//
//        let bgView: UIImageView = UIImageView(image: #imageLiteral(resourceName: "tabbarbg"))
//        bgView.frame = self.tabBar.bounds
//        self.tabBar.addSubview(bgView)
        setPosition()
        for vc in self.viewControllers! {
            vc.tabBarItem.title = nil
            vc.tabBarItem.imageInsets = UIEdgeInsets(top: 20, left: 0, bottom: -20, right: 0)
        }
    
        self.selectedIndex = 1
        
        self.tabBar.clipsToBounds = true
        // self.tabBar.backgroundImage = UIImage(named: "tabbarbg")
        //self.tabBar.backgroundColor = UIColor(patternImage: UIImage(named: "tabbarbg")!)
        // self.tabBarController?.tabBar.insertSubview(bgView, at: 1)
        // self.tabBar.backgroundImage = UIImage()
        //self.tabBar.clipsToBounds = true
        //self.tabBar.backgroundColor = UIColor(patternImage: UIImage(named: "tabbarbg")!)
        let image = UIImage(named: "tabbarbg")
        if let image = image {
            let centerImage: Bool = true
            var resizeImage: UIImage?
            let size = CGSize(width: UIScreen.main.bounds.size.width, height: tabBar.bounds.height+100)
            UIGraphicsBeginImageContextWithOptions(size, false, 0)
            if centerImage {
                //if you want to center image, use this code
                image.draw(in: CGRect(origin: CGPoint(x: (size.width-image.size.width)/2, y: 0), size: image.size))
            }
            else {
                //stretch image
                image.draw(in: CGRect(origin: CGPoint.zero, size: size))
            }
            resizeImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            tabBar.backgroundImage = resizeImage!.withRenderingMode(.alwaysOriginal)
            // tabBar.backgroundColor = UIColor(patternImage: resizeImage!.withRenderingMode(.automatic))
        }
    }
    
    func setPosition() {
        tabBarController?.tabBar.translatesAutoresizingMaskIntoConstraints = false
        tabBarController?.tabBar.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
        tabBarController?.tabBar.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
        tabBarController?.tabBar.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    func tabBarController(_: UITabBarController, didSelect: UIViewController) {
        gNav1 = nil
        gNav2 = nil
        gNav3 = nil
        gNav4 = nil
        gNav5 = nil
        gIsLevel1 = false
        if didSelect.view.tag == 101 {
            gNav1 = nav1
        }
        else if didSelect.view.tag == 102 {
            gNav2 = nav2
        }
        if didSelect.view.tag == 103 {
            gNav3 = nav3
        }
        else if didSelect.view.tag == 104 {
            gNav4 = nav4
        }
        else if didSelect.view.tag == 105 {
            gNav5 = nav5
        }
    }
    
    
//    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
//        print("Selected \(viewController.title!)")
//    }
}
