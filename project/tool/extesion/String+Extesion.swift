//
//  String+Extesion.swift
//  project
//
//  Created by juswin01 on 2023/7/21.
//

import Foundation

extension String {
    
    /// 格式化成人名币金额， 带 “¥”符号，保留2位小数
    var rmb: String {
        var price_rmb = ""
        if let price = self.nx.double {
            price_rmb = String(format: "¥ %.2f", price)
        } else {
            price_rmb = "¥ -"
        }
        return price_rmb
    }
    
    /// 将金额转换为“万”为单位
    var thousandUnit: String {
        var price_rmb = ""
        if let price = self.nx.double {
            if price / 10000 >= 1 {
                price_rmb = String(format: "%.2f万", price / 10000)
            }else {
                if price == 0 {
                    price_rmb = String(format: "0", price)
                }else {
                    price_rmb = String(format: "%.2f", price)
                }
            }
        }
        return price_rmb
    }
}

extension String {
    
    /// 随机字符串
    static var random: String {
        let identifier = CFUUIDCreate(nil)
        let identifierString = CFUUIDCreateString(nil, identifier) as String
        let cstr = identifierString.cString(using: .utf8)
        var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
        CC_MD5(cstr!, CC_LONG(strlen(cstr!)), &digest)
        var output = String()
        for i in digest {
            output = output.appendingFormat("%02X", i)
        }
        return output
    }
}

extension String {
    
    var nsString: NSString {
        return self as NSString
    }
    
    var int: Int {
        return nsString.integerValue
    }
    
    var int32: Int32 {
        return nsString.intValue
    }
    
    var float: Float {
        return nsString.floatValue
    }
    
    var cgFloat: CGFloat {
        return nsString.floatValue.cgFloat
    }
    
    var double: Double {
        return nsString.doubleValue
    }
    
    /// 保留一位小数，.0隐藏小数
    var double1f: String {
        let doubleVS = roundTo(places: 1).string
        guard !doubleVS.contains(".0") else {
            guard let result = doubleVS.components(separatedBy: ".0").first else { return doubleVS }
            return result
        }
        return doubleVS
    }
    
    /// 修正进度丢失
    var reviseAccuracy: String {
        guard let conversionValue = Double(self) else { return self }
        let doubleString = String(format: "%lf", conversionValue)
        let decNumber = NSDecimalNumber(string: doubleString)
        return decNumber.stringValue
    }
}

extension String {
    
    /// 拨打电话
    func call() {
        let phone = "telprompt://" + self
        if let url = URL(string: phone) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    /// 去敏感银行卡号,显示前四位和后四位,中间*号
    var secretBankCard: String {
        guard count > 7 else { return self }
        let font = String(self.prefix(4))
        let behind = String(self.suffix(4))
        var s = ""
        for i in 0..<count - font.count - behind.count {
            s += "*"
            if i > 4, i % 4 == 0 {
                s += " "
            }
        }
        return font + " " + s + " " + behind
    }
    
    /// 去敏感身份证号,显示前四位和后四位,中间*号
    var secretIdCard: String {
        guard count > 7 else { return self }
        let font = String(self.prefix(4))
        let behind = String(self.suffix(4))
        var s = ""
        for _ in 0..<count - font.count - behind.count {
            s += "*"
        }
        return font + s + behind
    }
    
    /// 去敏感姓名
    var secretName: String {
        guard count > 0 else { return self }
        let font = String(self.prefix(1))
        var s = ""
        for _ in 0..<self.count - 1 {
            s += "*"
        }
        return font + s
    }
}

// MARK: - URL字符串的编码与解码
extension String {
    
    // 将原始的url编码为合法的url
    func urlEncoded() -> String {
        let characterToEscape = "?!@#$^&%*+,:;='\"`<>()[]{}/\\| "
        let allowedCharacters = NSCharacterSet(charactersIn: characterToEscape).inverted
        let encodeString = addingPercentEncoding(withAllowedCharacters: allowedCharacters)
        return encodeString ?? ""
    }
}
