//
//  BaseNavigationController.swift
//  ios-project-base
//
//  Created by juswin01 on 2023/7/20.
//

import UIKit

class BaseNavigationController: UINavigationController {
    
  
}

extension BaseNavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: StatusBarStyle
extension BaseNavigationController {

    // 子 ViewController 的 StatusBarStyle
    override var childForStatusBarStyle: UIViewController? { topViewController }
    
}

// MARK: Orientation
extension BaseNavigationController {
    
    // 屏幕自动翻转
    override var shouldAutorotate: Bool { topViewController?.shouldAutorotate ?? false }
    
    // 屏幕旋转方向
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask { topViewController?.supportedInterfaceOrientations ?? .portrait }
    
    // 弹出ViewController 的屏幕旋转方向
    override var preferredInterfaceOrientationForPresentation: UIInterfaceOrientation { topViewController?.preferredInterfaceOrientationForPresentation ?? .portrait }
}

// MARK: Hides Bottom Bar
extension BaseNavigationController {
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if !children.isEmpty { viewController.hidesBottomBarWhenPushed = true }
        super.pushViewController(viewController, animated: animated)
    }
}
