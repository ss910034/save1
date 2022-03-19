//
//  TabHomeTableViewController.swift
//  save
//
//  Created by Frank Liu on 2021/10/21.
//

import UIKit

var gNav1:UINavigationController?
var gNav2:UINavigationController?
var gNav3:UINavigationController?
var gNav4:UINavigationController?
var gNav5:UINavigationController?
var gNava:UINavigationController?

var gIsLevel1 = false
var gTapBarController1:UITabBarController?
var gTapBarController2:UITabBarController?
var gTapBarController3:UITabBarController?

class TabHomeTableViewController: UITabBarController, UITabBarControllerDelegate {

    var nav1:UINavigationController? = nil
    var nav2:UINavigationController? = nil
    var nav3:UINavigationController? = nil
    var nav4:UINavigationController? = nil
    var nav5:UINavigationController? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        gIsLevel1 = true
        self.delegate = self
        setTabBarView()
        gTapBarController1 = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
//        bgView.contentMode = .scaleToFill
//        tabBar.addSubview(bgView)
//        let view = UIView(frame: CGRect(x: 0.0, y: 12.0, width: UIScreen.main.bounds.size.width, height: 2.0))
//        let imgView = UIImageView(frame: view.bounds)
//        imgView.image = UIImage(named: "tapbarbg")
//        imgView.contentMode = .scaleToFill
//        // view.backgroundColor = .orange
//        view.addSubview(imgView)
//        tabBar.addSubview(view)

        let tabOne = Tap1ViewController()
        nav1 = UINavigationController(rootViewController: tabOne)
        let tabOneBarItem = UITabBarItem(title: "", image: UIImage(named: "tap1"), selectedImage: UIImage(named: "tapd1"))
        tabOne.tabBarItem = tabOneBarItem
        nav1!.view.tag = 101
        gNav1 = nav1

        let tabTwo = Tap2ViewController()
        nav2 = UINavigationController(rootViewController: tabTwo)
        let tabTwoBarItem = UITabBarItem(title: "", image: UIImage(named: "tap2"), selectedImage: UIImage(named: "tapd2"))
        nav2!.view.tag = 102
        tabTwo.tabBarItem = tabTwoBarItem

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
         
//        if #available(iOS 15.0, *) {
//            let appearance = UITabBarAppearance()
//            appearance.configureWithOpaqueBackground()
//            appearance.backgroundImage = UIImage(named: "tabbarbg")!
//            tabBar.standardAppearance = appearance
//            tabBar.scrollEdgeAppearance = tabBar.standardAppearance
//        }
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
        if didSelect.view.tag == 101 {
            let vc:Tap1ViewController = didSelect.children[0] as! Tap1ViewController
            DispatchQueue.main.asyncAfter(deadline: .now()+0.05) {
                vc.pager.selectedIndex = 1
            }
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
}
