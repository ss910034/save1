//
//  WelcomePageViewController.swift
//  Fennec
//
//  Created by linyuta on 09/07/2017.
//  Copyright © 2017 Fennec. All rights reserved.
//

import UIKit

struct WelcomePageInputDataModel {
    var title: String
    var image: String
}

class WelcomePageViewController: UIPageViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        navigationController?.isNavigationBarHidden = true
        
        if let showFirstPage = showPageViewController(index: 0) {
            setViewControllers([showFirstPage], direction: .forward, animated: true, completion: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
       super.viewWillAppear(animated)
       
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)       // Or to rotate and lock
       // AppUtility.lockOrientation(.portrait, andRotateTo: .portrait)
       
   }

   override func viewWillDisappear(_ animated: Bool) {
       super.viewWillDisappear(animated)
       
       // Don't forget to reset when view is being removed
       // AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.all)
   }
    
    fileprivate func showPageViewController(index: Int) -> PageViewController? {
        print(index)
        AppDelegate.AppUtility.lockOrientation(UIInterfaceOrientationMask.portrait, andRotateTo: UIInterfaceOrientation.portrait)       // Or to rotate and lock

        if index == 3 {
//            Constants.setFirstHomeGuideShow()
            self.navigationController?.popViewController(animated: false)
            return nil
        }
        
        if index < 0 || index > 2 {
            return nil
        }

        let pageViewController = PageViewController(nibName: PageViewController.identifier, bundle: nil)
        pageViewController.index = index
        return pageViewController
    }
    
    func forWord(index: Int) {
        if let nextViewController = showPageViewController(index: index + 1) {
            setViewControllers([nextViewController], direction: .forward, animated: true, completion: nil)
        }
    }
}

    // MARK: UIPageViewControllerDataSource

extension WelcomePageViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! PageViewController).index
        index -= 1
        return showPageViewController(index: index)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        var index = (viewController as! PageViewController).index
        index += 1
        return showPageViewController(index: index)
    }
}
