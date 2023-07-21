//
//  AppConfig.swift
//  project
//
//  Created by juswin01 on 2023/7/21.
//

import Foundation
import UIKit
import MapKit

class AppConfig {
    static let `default` = AppConfig()
    private init() {}
    
    
}

extension AppConfig: VisibleViewControllerFindable{
    
    
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
    
    
    // MARK: - safeArea
    static var safeAreaInsets: UIEdgeInsets {
        if #available(iOS 11.0, *) {
            return keyWindow.safeAreaInsets
        }
        return UIEdgeInsets.zero
    }
    
    // MARK: - 当前正在显示的 ViewController
    static var visiableViewController: UIViewController? { Self.visiableViewController }
    
}

// 地图导航跳转
extension AppConfig {
    
    
    static navigateToMap(latitude: Double?, longitude: Double?, destName: String? = nil) {
        guard let latitude = latitude, let longitude = longitude else { return }
        let destName = destName ?? ""
        let actionSheet = UIAlertController(title: "请选择地图", message: nil, preferredStyle: .actionSheet)
        
        let appleAction = buildAppleMapAction(to: latitude, longitude: longitude, destName: destName)
        actionSheet.addAction(appleAction)
        
        
        if UIApplication.shared.canOpenURL(URL(string: "qqmap://")) {
            let tencentAction = buildTencentMapAction(to: latitude, longitude: longitude, destName: destName)
            actionSheet.addAction(tencentAction)
        }
        
        if UIApplication.shared.canOpenURL(URL(string: "iosamap://")) {
            let amapAction = buildAMapAction(to: latitude, longitude: longitude, destName: destName)
            actionSheet.addAction(amapAction)
        }
        
        if UIApplication.shared.canOpenURL(URL(string: "baidumap://")) {
            let baiduAction = buildBaiduMapAction(to: latitude, longitude: longitude, destName: destName)
            actionSheet.addAction(baiduAction)
        }
        
        if UIApplication.shared.canOpenURL(URL(string: "comgooglemaps://")) {
            let googleAction = buildGoogleMapAction(to: latitude, longitude: longitude, destName: destName)
            actionSheet.addAction(googleAction)
        }
        
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        actionSheet.addAction(cancelAction)
        
        visiableViewController?.present(actionSheet, animated: true, completion: nil)
    }
    
    
    /// 创建苹果地图 Action
    /// - Parameters:
    ///   - latitude: 经度
    ///   - longitude: 纬度
    ///   - destName: 目的地
    /// - Returns:UIAlertAction
    static func buildAppleMapAction(to latitude: Double, longitude: Double, destName: String) -> UIAlertAction {
        
        return UIAlertAction(title: "苹果地图", style: .default) { action in
            
            let loc = CLLocationCoordinate2DMake(latitude, latitude)
            let currentLocation = MKMapItem.forCurrentLocation()
            let toLocation = MKMapItem.init(placemark: MKPlacemark.init(coordinate: loc, addressDictionary: nil))
            //传入终点名称
            toLocation.name = destinationName
            let options =  [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving,
                              MKLaunchOptionsShowsTrafficKey: NSNumber.init(booleanLiteral: true)]
            MKMapItem.openMaps(with: [currentLocation,toLocation],launchOptions: options)
        }
        
    }
    
    /// 创建腾讯地图 Action
    /// - Parameters:
    ///   - latitude: 经度
    ///   - longitude: 纬度
    ///   - destName: 目的地
    /// - Returns:UIAlertAction
    static func buildTencentMapAction(to latitude: Double, longitude: Double, destName: String) -> UIAlertAction {
        
        //utf-8编码
        var charSet = CharacterSet.urlQueryAllowed
        charSet.insert(charactersIn: "#")
        
        return UIAlertAction(title: "腾讯地图", style: .default) { action in
            let format = "qqmap://map/routeplan?from=我的位置&type=drive&tocoord=%f,%f&to=%@&coord_type=&policy=0"
            let tecentmap =  String(format: format, lati, longi, destinationName)
            guard let urlString = tecentmap.addingPercentEncoding(withAllowedCharacters: charSet),
                  let url = URL(string: urlString) else { return }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    /// 创建高德地图 Action
    /// - Parameters:
    ///   - latitude: 经度
    ///   - longitude: 纬度
    ///   - destName: 目的地
    /// - Returns:UIAlertAction
    static func buildAMapAction(to latitude: Double, longitude: Double, destName: String) -> UIAlertAction {
        
        //utf-8编码
        var charSet = CharacterSet.urlQueryAllowed
        charSet.insert(charactersIn: "#")
        
        return UIAlertAction(title: "高德地图", style: .default) { (action) in
            let format = "iosamap://path?sourceApplication=&sid=&dlat=%f&dlon=%f&dname=%@"
            let amap = String(format: format, lati, longi, destinationName)
            guard let urlString = amap.addingPercentEncoding(withAllowedCharacters: charSet),
                  let url = URL(string: urlString) else { return }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    /// 创建百度地图 Action
    /// - Parameters:
    ///   - latitude: 经度
    ///   - longitude: 纬度
    ///   - destName: 目的地
    /// - Returns:UIAlertAction
    static func buildBaiduMapAction(to latitude: Double, longitude: Double, destName: String) -> UIAlertAction {
        
        //utf-8编码
        var charSet = CharacterSet.urlQueryAllowed
        charSet.insert(charactersIn: "#")
        
        return UIAlertAction(title: "百度地图", style: .default) { (action) in
            let format = "baidumap://map/direction?origin={{我的位置}}&destination=name:%@|latlng:%f,%f&mode=driving&coord_type=gcj02"
            let baidumap = String(format: format, destinationName, lati, longi)
            guard let urlString = baidumap.addingPercentEncoding(withAllowedCharacters: charSet),
                  let url = URL(string: urlString) else { return }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    
    /// 创建Google地图 Action
    /// - Parameters:
    ///   - latitude: 经度
    ///   - longitude: 纬度
    ///   - destName: 目的地
    /// - Returns:UIAlertAction
    static func buildGoogleMapAction(to latitude: Double, longitude: Double, destName: String) -> UIAlertAction {
        
        //utf-8编码
        var charSet = CharacterSet.urlQueryAllowed
        charSet.insert(charactersIn: "#")
        
        return UIAlertAction(title: "谷歌地图", style: .default) { (action) in
            let format = "comgooglemaps://?x-source=我的位置&x-success=%@&saddr=&daddr=%f,%f&directionsmode=driving&coord_type=gcj02"
            let googlemap = String(format:format , destinationName, lati, longi)
            guard let urlString = googlemap.addingPercentEncoding(withAllowedCharacters: charSet),
                  let url = URL(string: urlString) else { return }
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

}
