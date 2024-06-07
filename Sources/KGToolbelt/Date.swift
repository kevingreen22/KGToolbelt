//
//  Date.swift
//
//  Created by Kevin Green on 8/8/22.
//

import Foundation

public extension Date {
    
    /// Formats a date object to a string representation in the medium format, omiting the timestamp. i.e. “Nov 23, 1937”.
    func mediumDateStamp() -> String {
        let dfs = DateFormatter()
        dfs.dateStyle = .medium
        dfs.timeStyle = .none
        return dfs.string(from: self)
    }
    
    /// Formats a Date object to just a standard american format with optional time stamp.
    /// - Returns: A string representation of the date format.
    func americanDateStamp(year: Bool = true, time: Bool = false) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        if year && time == false {
            formatter.setLocalizedDateFormatFromTemplate("MMM d, yyyy")
        } else if year && time {
            formatter.setLocalizedDateFormatFromTemplate("MMM d, yyyy - h:mm")
        } else if year == false && time {
            formatter.setLocalizedDateFormatFromTemplate("MMM d - h:mm")
        }
        return formatter.string(from: self)
    }
    
    /// Adds months to todays date.
    /// - Parameter months: The number of months to add.
    /// - Returns: A date thats 2 months longer than the current date.
    func addingMonths(_ months: Int) -> Date {
        var dateComponent = DateComponents()
        dateComponent.month = months
        return Calendar.current.date(byAdding: dateComponent, to: self)!
    }
    
    /// Formats a Date object to a weekday. i.e "Monday"
    /// - Returns: A string representation of the date format.
    var getCurrentWeekdayAsString: String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.setLocalizedDateFormatFromTemplate("EEEE")
        let weekday = formatter.string(from: self)
        return weekday
    }
    
    /// Formats a Date object to a day of the month. i.e "15" or "6"
    /// - Returns: A string representation of the date format.
    var getCurrentDayNumAsString: String {
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.setLocalizedDateFormatFromTemplate("d")
        let day = formatter.string(from: self)
        return day
    }
    
    /// Adds the amount of days before/after "today".
    /// - Parameter days: 1 for tomorrow, 0 for today,  -1 for yesterday, etc.
    func addToDate(by days: Int) -> Date {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        var dayComponent = DateComponents()
        dayComponent.day = days
        guard let date = calendar.date(byAdding: dayComponent, to: self) else { return Date() }
        return date
    }
    
}

