//
//  UIViewController+NavigaitonBackInterceptor.swift
//  ios-project-base
//
//  Created by juswin01 on 2023/7/20.
//

import UIKit

// MARK: 导航栏返回事件拦截器
public protocol NavigationBarInterceptor {
    
    // 拦截导航栏返回按钮点击事件
    func navigationBarShouldPop() -> Bool
}


extension UINavigationController: UINavigationBarDelegate, UIGestureRecognizerDelegate {
    
    public func navigationBar(_ navigationBar: UINavigationBar, shouldPop item: UINavigationItem) -> Bool {
        guard let itemsCount = navigationBar.items?.count else { return false }
        if viewControllers.count < itemsCount { return true }
        guard let currentViewController = topViewController,
              let interceptor = currentViewController as? NavigationBarInterceptor else { return true }
        var shouldPop = interceptor.navigationBarShouldPop()
        if shouldPop {
            DispatchQueue.main.async { self.popViewController(animated: true) }
        }
        else {
            navigationBar.subviews.forEach { subview in
                if subview.alpha > 0.0 && subview.alpha < 1.0 {
                    UIView.animate(withDuration: 0.25, animations: { subview.alpha = 1.0 })
                }
            }
        }
        return false
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        guard let itemsCount = navigationBar.items?.count else { return false }
        if viewControllers.count < itemsCount { return true }
        guard let currentViewController = topViewController,
              let interceptor = currentViewController as? NavigationBarInterceptor else { return true }
        return interceptor.navigationBarShouldPop()
    }
}
