//
//  BaseTabBarController.swift
//  ios-project-base
//
//  Created by juswin01 on 2023/7/20.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        edgesForExtendedLayout = .all
        extendedLayoutIncludesOpaqueBars = true

    }
    
}

// MARK: Orientation
extension BaseTabBarController {
    
    // 屏幕自动翻转
    override var shouldAutorotate: Bool { topViewController?.shouldAutorotate ?? false }
    
    // 屏幕旋转方向
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { topViewController?.supportedInterfaceOrientations ?? .portrait }
    
    // 弹出ViewController 的屏幕旋转方向
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation { topViewController?.preferredInterfaceOrientationForPresentation ?? .portrait }
}
