//
//  Array+Extesion.swift
//  project
//
//  Created by juswin01 on 2023/7/21.
//

import Foundation

extension Array {
    
    mutating func add(array: [Element], refresh: Bool) {
        if refresh {
            self = array
        } else {
            self += array
        }
    }
    
    func distinct() -> [Element] where Element: Comparable {
        var _array = [Element]()
        for e in self {
            if !_array.contains(e) {
                _array.append(e)
            }
        }
        return _array
    }
}
