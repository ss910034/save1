//
//  ActivityPagerViewController.swift
//  HereHearV2
//
//  Created by Frank Liu on 2019/7/16.
//  Copyright © 2019 Frank Liu. All rights reserved.
//

import DTPagerController
import UIKit

class ConsumePagerViewController: DTPagerController {

    var vcAry:[UIViewController] = []
    var titleAry:[String] = []

    init() {
        // super.init(viewControllers: [])
        
        for i in stride(from: 1, through: 12, by: 2) {
            let vc = InvoiceRecordViewController()
            let nav = UINavigationController(rootViewController: vc)
            self.vcAry.append(nav)
            self.titleAry.append(String(format: "%d-%d月", i, i+1))
        }

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
            DispatchQueue.main.asyncAfter(deadline: .now()+0.2) {
                segmentedControl.setSelectedSegmentIndex(0, animated: true)
            }
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
