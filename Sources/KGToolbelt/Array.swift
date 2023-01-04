//
//  Array.swift
//
//  Created by Kevin Green on 10/28/22.
//

import Foundation

public extension Array where Element: Equatable {
    
    /// Replaces an element with the given new element.
    /// Both elements must be of the same type.
    mutating func repalce(_ current: Element, new: Element) {
        for (i,e) in enumerated() {
            if e == current {
                self[i] = new
                break
            }
        }
    }
    
}
