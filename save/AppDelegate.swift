//
//  AppDelegate.swift
//  save
//
//  Created by Frank Liu on 2021/10/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var hudTimer:Timer!
    var isHudShow = false
    var orientationLock = UIInterfaceOrientationMask.all

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // Thread.sleep(forTimeInterval: 1.0)
        UITabBar.appearance().tintColor = Constants.getDefaultTextColor()
        UITabBar.appearance().barTintColor = .white // your color
        // UITabBar.appearance().backgroundImage = UIImage(named: "tabbarbg")
        // [[UITabBar appearance] setShadowImage:[UIImage imageNamed:@"transparentShadow.png"]];

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return self.orientationLock
    }
    
    struct AppUtility {
        static func lockOrientation(_ orientation: UIInterfaceOrientationMask) {
            if let delegate = UIApplication.shared.delegate as? AppDelegate {
                delegate.orientationLock = orientation
            }
        }
            
        static func lockOrientation(_ orientation: UIInterfaceOrientationMask, andRotateTo rotateOrientation:UIInterfaceOrientation) {
            self.lockOrientation(orientation)
            UIDevice.current.setValue(rotateOrientation.rawValue, forKey: "orientation")
        }
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    func showLoadingHUD() {
        if isHudShow {
            return
        }
        
        let lockQueue = DispatchQueue(label: "self")
        lockQueue.sync {
            DispatchQueue.main.async(execute: {
                self.hudTimer = Timer.scheduledTimer(timeInterval: 2000.0, target: self, selector: #selector(self.hideAllHUD), userInfo: nil, repeats: false)
                SVProgressHUD.show()
                SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
                self.isHudShow = true
            })
        }
    }
    
    func hideHUD() {
        if !isHudShow {
            return
        }
        
        let lockQueue = DispatchQueue(label: "self")
        lockQueue.sync {
            DispatchQueue.main.async(execute: {
                SVProgressHUD.dismiss()
                SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
                self.isHudShow = false
                self.hudTimer.invalidate()
            })
        }
    }
    
    @objc func hideAllHUD() {
        DispatchQueue.main.async(execute: {
            SVProgressHUD.dismiss()
            SVProgressHUD.setDefaultMaskType(SVProgressHUDMaskType.black)
            self.isHudShow = false
        })
    }


}

