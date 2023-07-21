//
//  ptotocols.swift
//  ios-project-base
//
//  Created by juswin01 on 2023/7/20.
//

import UIKit

// MARK: - XIB 加载
protocol NibLoadable {}
extension NibLoadable {
    
    static func loadFromNib() -> Self {  return Bundle.main.loadNibNamed("\(self)", owner: nil, options: nil)?.last as! Self }
}

// MARK: - 注册cell
protocol Registerable {}
extension Registerable {
    static var identifier: String { return "\(self)" }
    static var nib: UINib? { return UINib(nibName: "\(self)", bundle: nil) }
    static var isHasNib: Bool { return Bundle.main.path(forResource: "\(self)", ofType: "nib") != nil }
}

// MARK: - Storyboad 加载
protocol StoryboardLoadable {}
extension StoryboardLoadable {
    static func load(name: String) -> Self {
        let sb = UIStoryboard(name: name, bundle: Bundle.main)
        let identifier = "\(self)"
        return sb.instantiateViewController(withIdentifier: identifier) as! Self
    }
}

// MARK: - 默认注册
extension UIView: NibLoadable {}
extension UIViewController: NibLoadable {}
extension UITableViewCell: Registerable {}
extension UICollectionReusableView: Registerable {}
extension UITableViewHeaderFooterView: Registerable {}


// MARK: - 获取当前控制器
protocol VisibleViewControllerFindable {}
extension VisibleViewControllerFindable {
    /// 递回查找获取当前正在显示的 ViewController
    /// - Parameter rootViewController: 默认从 Application 的 rootViewController 开始查找
    /// - Returns: 当前正在显示的 ViewController 可能为 nil
    static func visibleViewController(from rootViewController: UIViewController? = keyWindow.rootViewController) -> UIViewController? {
        if let navigaitonController = rootViewController as? UINavigationController {
            return visibleViewController(from: navigaitonController)
        }
        if let tabBarController = rootViewController as? UITabBarController {
            return visibleViewController(from: tabBarController)
        }
        if let presentViewController = rootViewController?.presentedViewController {
            return visibleViewController(from: presentViewController)
        }
        return rootViewController
    }
    
    static func visibleNavgationController(from rootViewController: UIViewController? = keyWindow.rootViewController) -> UINavigationController? {
        if let navigationController = rootViewController as? UINavigationController {
            return navigationController
        }
        if let tabBarController = rootViewController as? UITabBarController {
            if let selectedController = tabBarController.selectedViewController {
                return visibleNavgationController(from: selectedController)
            }
        }
        if let presentedController = rootViewController?.presentedViewController {
            return visibleNavgationController(from: presentedController)
        }
        return nil
    }
    
    
    // MARK: - 当前window
    static var keyWindow: UIWindow {
        if #available(iOS 15.0, *) {
            let keyWindow = UIApplication.shared.connectedScenes.map({ $0 as? UIWindowScene }).compactMap({ $0 }).first?.windows.first ?? UIWindow()
            return keyWindow
        }
        else {
            let keyWindow = UIApplication.shared.windows.first ?? UIWindow()
            return keyWindow
        }
    }
}

