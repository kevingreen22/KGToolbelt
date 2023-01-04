//
//  CurrencyFormatter.swift
//
//  Created by Kevin Green on 11/25/22.
//

import Foundation

public extension Locale {
    
    /// Gets the current Locale's currency identifier code.
    static let code: String = {
        if #available(iOS 16, *) {
            return Locale.current.currency?.identifier ?? "USD"
        } else {
            // Fallback on earlier versions
            return Locale.current.currencyCode ?? "USD"
        }
    }()
}




