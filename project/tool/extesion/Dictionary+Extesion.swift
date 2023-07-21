//
//  Dictionary+Extesion.swift
//  project
//
//  Created by juswin01 on 2023/7/21.
//

import Foundation

extension Dictionary {
    
    /// 合并字典
    /// 接收的参数是一个键值对时，
    /// 就可以添加到原有的字典中，
    /// 并且对原有字典的重复值进行覆盖为新值，
    /// 不重复则保留
    ///
    /// - Parameter ohter: 字典
    mutating func merge<S>(_ other: S)
    where S: Sequence,
            S.Iterator.Element == (key: Key, value: Value) {
        for (k, v) in other {
            self[k] = v
        }
    }
}
