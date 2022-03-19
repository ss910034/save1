//
//  ActivityPagerViewController.swift
//  HereHearV2
//
//  Created by Frank Liu on 2019/7/16.
//  Copyright © 2019 Frank Liu. All rights reserved.
//

import DTPagerController
import UIKit

class HomePagerViewController: DTPagerController {

    var vcAry:[UIViewController] = []
    var titleAry:[String] = []

    init() {
        // super.init(viewControllers: [])
        let vc1 = HomeDiscountPageViewController()
        let nav1 = UINavigationController(rootViewController: vc1)
        vcAry.append(nav1)
        
        let vc2 = HomePageViewController()
        let nav2 = UINavigationController(rootViewController: vc2)
        vcAry.append(nav2)
        
        let vc3 = HomeHotPageViewController()
        let nav3 = UINavigationController(rootViewController: vc3)
        vcAry.append(nav3)
        
        titleAry.append("最新優惠")
        titleAry.append("首頁")
        titleAry.append("熱賣排行")

        // swiftlint:disable line_length
        guard let segmentedControl = HMSegmentedControl(sectionTitles: titleAry) else {
            fatalError("HMSegmentedControl cannot be created")
        }
        super.init(viewControllers: vcAry, pageSegmentedControl: segmentedControl)
        // swiftlint:enable line_length
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let segmentedControl = pageSegmentedControl as? HMSegmentedControl {
            segmentedControl.segmentWidthStyle = .fixed
            segmentedControl.segmentEdgeInset = UIEdgeInsets(top: 0, left: 30, bottom: 0, right: 30)
            segmentedControl.setTitleTextAttributes([.foregroundColor: Constants.getYellowColor(), .font: UIFont.systemFont(ofSize: 17.0)], for: .selected)
            segmentedControl.setTitleTextAttributes([.foregroundColor: Constants.getDefaultTextColor(), .font: UIFont.systemFont(ofSize: 17.0)], for: .normal)
            segmentedControl.selectionIndicatorColor = Constants.getYellowColor()
            segmentedControl.selectionIndicatorHeight = 3.0
            segmentedControl.selectionIndicatorLocation = .down
            segmentedControl.backgroundColor = .clear
//          segmentedControl.selectionStyle = .textWidthStripe
//          segmentedControl.segmentWidthStyle = .dynamic
            segmentedControl.setSelectedSegmentIndex(1, animated: false)
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
