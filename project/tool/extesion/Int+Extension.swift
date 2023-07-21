//
//  Int+Extension.swift
//  project
//
//  Created by juswin01 on 2023/7/21.
//

import Foundation


extension Int {
    
    static let hanzis = ["零", "一", "二", "三", "四", "五", "六", "七", "八", "九", "十"]
    
    var hanzi: String {
        if self > 10 {
            return ""
        }
        return Int.hanzis[self]
    }
}
