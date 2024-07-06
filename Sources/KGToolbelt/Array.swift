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



extension Array: RawRepresentable where Element: Codable {
    
    /// Allows Arrays to be saved in AppStorage/SceneStorage
    public init?(rawValue: String) {
        guard let data = rawValue.data(using: .utf8),
              let result = try? JSONDecoder().decode([Element].self, from: data)
        else {
            return nil
        }
        self = result
    }

    public var rawValue: String {
        guard let data = try? JSONEncoder().encode(self),
              let result = String(data: data, encoding: .utf8)
        else {
            return "[]"
        }
        return result
    }
}
