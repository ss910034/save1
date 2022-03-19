//
//  ActivityPagerViewController.swift
//  HereHearV2
//
//  Created by Frank Liu on 2019/7/16.
//  Copyright © 2019 Frank Liu. All rights reserved.
//

import DTPagerController
import HMSegmentedControl
import UIKit

var gPagerIndexAry:[Int] = []

class ProductPagerViewController: DTPagerController {

    var vcAry:[UIViewController] = []
    var titleAry:[String] = []

    init() {
        // super.init(viewControllers: [])
        for d in 0..<gListenParentName.count {
            let vc = ActivityPageViewController()
            let nav = UINavigationController(rootViewController: vc)
            vcAry.append(nav)
            titleAry.append(gListenParentName[d])
        }

        // swiftlint:disable line_length
        guard let segmentedControl = HMSegmentedControl(sectionTitles: titleAry) else {
            fatalError("HMSegmentedControl cannot be created")
        }
        super.init(viewControllers: vcAry, pageSegmentedControl: segmentedControl)
        // swiftlint:enable line_length

        // title = "CustomPagerController"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let segmentedControl = pageSegmentedControl as? HMSegmentedControl {
            segmentedControl.segmentWidthStyle = .dynamic
            segmentedControl.segmentEdgeInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
            segmentedControl.setTitleTextAttributes([.foregroundColor: Constants.getPurpleColor(), .font: UIFont.systemFont(ofSize: 17.0)], for: .selected)
            segmentedControl.setTitleTextAttributes([.foregroundColor: Constants.getDefaultFontColor(), .font: UIFont.systemFont(ofSize: 17.0)], for: .normal)
            segmentedControl.selectionIndicatorColor = Constants.getPurpleColor()
            segmentedControl.selectionIndicatorHeight = 3.0
            segmentedControl.selectionIndicatorLocation = .down
            segmentedControl.backgroundColor = .clear
//            segmentedControl.selectionStyle = .textWidthStripe
//            segmentedControl.segmentWidthStyle = .dynamic

            var idx = 0
            if gListenFrom == 2 {
                for d in gListenParentDefaultTab {
                    if d == true {
                        idx = gListenParentDefaultTab.firstIndex(of: d)!
                        break
                    }
                }
            }

            segmentedControl.setSelectedSegmentIndex(UInt(idx), animated: true)
            // 首頁進入免費聽聽
            if idx != 0 {
                var x = 178
                if Constants.getLanguageIdentity() == "TW" || Constants.getLanguageIdentity() == "CN" || Constants.getLanguageIdentity() == "HK" || Constants.getLanguageIdentity() == "MO" {
                    if UIDevice.current.screenType == .iPhone_XR_11 {
                        x = 178
                    }
                    else if UIDevice.current.screenType == .iPhone_XSMax_11ProMax {
                        x = 178
                    }
                    else if UIDevice.current.screenType == .iPhones_X_XS_11Pro {
                        x = 192
                    }
                    else if UIDevice.current.screenType == .iPhones_6Plus_6sPlus_7Plus_8Plus {
                        x = 178
                    }
                    else if UIDevice.current.screenType == .iPhones_6_6s_7_8 {
                        x = 192
                    }
                    segmentedControl.scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
                }
                else {
                    x = 320
                    if UIDevice.current.screenType == .iPhone_XR_11 {
                        x = 320
                    }
                    else if UIDevice.current.screenType == .iPhone_XSMax_11ProMax {
                        x = 334
                    }
                    else if UIDevice.current.screenType == .iPhones_X_XS_11Pro {
                        x = 334
                    }
                    else if UIDevice.current.screenType == .iPhones_6Plus_6sPlus_7Plus_8Plus {
                        x = 320
                    }
                    else if UIDevice.current.screenType == .iPhones_6_6s_7_8 {
                        x = 334
                    }
                    segmentedControl.scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
                }
            }
            // 首頁進品牌故事
            else if idx == 0 && gListenFrom == 3{
                var x = 178
                if Constants.getLanguageIdentity() == "TW" || Constants.getLanguageIdentity() == "CN" || Constants.getLanguageIdentity() == "HK" || Constants.getLanguageIdentity() == "MO" {
                    if UIDevice.current.screenType == .iPhone_XR_11 {
                        x = 178
                    }
                    else if UIDevice.current.screenType == .iPhone_XSMax_11ProMax {
                        x = 178
                    }
                    else if UIDevice.current.screenType == .iPhones_X_XS_11Pro {
                        x = 192
                    }
                    else if UIDevice.current.screenType == .iPhones_6Plus_6sPlus_7Plus_8Plus {
                        x = 178
                    }
                    else if UIDevice.current.screenType == .iPhones_6_6s_7_8 {
                        x = 192
                    }
                    segmentedControl.scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
                }
                else {
                    x = 320
                    if UIDevice.current.screenType == .iPhone_XR_11 {
                        x = 320
                    }
                    else if UIDevice.current.screenType == .iPhone_XSMax_11ProMax {
                        x = 334
                    }
                    else if UIDevice.current.screenType == .iPhones_X_XS_11Pro {
                        x = 334
                    }
                    else if UIDevice.current.screenType == .iPhones_6Plus_6sPlus_7Plus_8Plus {
                        x = 320
                    }
                    else if UIDevice.current.screenType == .iPhones_6_6s_7_8 {
                        x = 334
                    }
                    segmentedControl.scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
                }
            }
            else {
                
            }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setUpSegmentedControl(viewControllers: [UIViewController]) {
        super.setUpSegmentedControl(viewControllers: viewControllers)

        perferredScrollIndicatorHeight = 0

        if let segmentedControl = pageSegmentedControl as? HMSegmentedControl {
            segmentedControl.selectionIndicatorColor = UIColor.blue
        }
    }

    override func updateAppearanceForSegmentedItem(at index: Int) {
        // Does not do anything since custom page control does not support title/image update
    }
    
}

extension HMSegmentedControl: DTSegmentedControlProtocol {
    public func setImage(_ image: UIImage?, forSegmentAt segment: Int) {
        // Custom page control does not support
    }

    public func setTitle(_ title: String?, forSegmentAt segment: Int) {
        // Custom page control does not support
    }

    public func setTitleTextAttributes(_ attributes: [NSAttributedString.Key: Any]?, for state: UIControl.State) {
        if state == UIControl.State.normal {
            titleTextAttributes = attributes
        } else if state == UIControl.State.selected {
            selectedTitleTextAttributes = attributes
        }
    }
}
