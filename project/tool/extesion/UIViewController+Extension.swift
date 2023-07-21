//
//  UIViewController+Extension.swift
//  project
//
//  Created by juswin01 on 2023/7/21.
//

import Foundation

extension UIViewController {
    
    /// NavigationController Push
    /// - Parameter vc: 入栈的 ViewController 实例
    func push<T>(vc: T) where T: UIViewController { navigationController?.pushViewController(vc, animated: true) }
    
    /// NavigationController Pop
    /// - Parameter vc: 出栈 ViewController 实例
    func pop<T>(vc: T) where T: UIViewController { navigationController?.popViewController(animated: true) }
    
    /// NavigationController Pop To Root
    /// - Parameter animate: 是否动画
    func popToRoot<T>(animate: Bool = true) where T: UIViewController { navigationController?.popToRootViewController(animated:  animate) }
    
    
    /// NavigationController Pop to 指定 UIViewController
    /// - Parameters:
    ///   - vc: 指定的 UIViewController 实例
    ///   - animate: 是否动画 
    func pop<T>(to vc: T, animate: Bool = true) where T: UIViewController { navigationController?.popToViewController(vc, animated: animate) }
    
    ///
    /// - Parameters:NavigationController Pop to 指定 UIViewController
    ///   - vcType: 指定 UIVIewCOntroller 的类型
    ///   - animate: 是否动画
    func pop<T>(to vcType: T, animate: Bool = true) where T: UIViewController {
        navigationController?.viewControllers.forEach({ vc in
            if vc.isKind(of: vcType) { navigationController?.popToViewController(vc, animated: animate) }
        })
    }
}
