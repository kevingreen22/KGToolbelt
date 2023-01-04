//
//  Date.swift
//
//  Created by Kevin Green on 8/8/22.
//

import Foundation

public extension Date {
    
    /// Formats a date object to a string representation in the medium format, omiting the timestamp. i.e. “Nov 23, 1937”.
    func myDateFormatted() -> String {
        let dfs = DateFormatter()
        dfs.dateStyle = .medium
        dfs.timeStyle = .none
        return dfs.string(from: self)
    }
    
    
    /// Adds months to todays date.
    /// - Parameter months: The number of months to add.
    /// - Returns: A date thats 2 months longer than the current date.
    func addingMonths(_ months: Int) -> Date {
        var dateComponent = DateComponents()
        dateComponent.month = months
        return Calendar.current.date(byAdding: dateComponent, to: self)!
    }
    
}
