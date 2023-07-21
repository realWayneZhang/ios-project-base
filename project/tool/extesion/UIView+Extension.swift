//
//  UIView+Extension.swift
//  project
//
//  Created by juswin01 on 2023/7/21.
//

import UIKit

extension UIView {
    
    //将当前视图转为UIImage
    func asImage() -> UIImage {
        let renderer = UIGraphicsImageRenderer(bounds: bounds)
        return renderer.image { rendererContext in
            layer.render(in: rendererContext.cgContext)
        }
    }
    
    /// 方法一：将View 转换为 UIImage
    var fxImage: UIImage {
        // 第一个参数表示区域大小。第二个参数表示是否是非透明的。如果需要显示半透明效果，需要传NO，否则传YES。第三个参数就是屏幕密度了，关键就是第三个参数 UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(bounds.size, true, 0.0)
        let ctx = UIGraphicsGetCurrentContext()
        layer.render(in: ctx!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
        
    }
}

// MARK: - 坐标
extension UIView {
    /// width
    var width: CGFloat {
        get {
            return frame.size.width
        }
        
        set {
            frame.size.width = newValue
        }
    }
    
    /// height
    var height: CGFloat {
        get {
            return frame.size.height
        }
        
        set {
            frame.size.height = newValue
        }
    }
    
    /// centerY
    var centerY: CGFloat {
        get {
            return center.y
        }
        
        set {
            center.y = newValue
        }
    }
    
    /// centerX
    var centerX: CGFloat {
        get {
            return center.x
        }
        set {
            center.x = newValue
        }
    }
    
    /// size
    var size: CGSize {
        get {
            return frame.size
        }
        
        set {
            frame.size = newValue
        }
    }
    
    var top: CGFloat {
        get {
            return frame.minY
        }
    }
    
    var left: CGFloat {
        get {
            return frame.minX
        }
    }
    
    var right: CGFloat {
        get {
            return frame.maxX
        }
    }
    
    var bottom: CGFloat {
        get {
            return frame.maxY
        }
    }
}
