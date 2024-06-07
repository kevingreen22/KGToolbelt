//
//  Date.swift
//
//  Created by Kevin Green on 8/8/22.
//

import Foundation

public extension Date {
    
    /// DateFormatter() has 5 format style options for each of Date and Time. These are:
    /// .none .short .medium .long .full
    
    /// DATE      TIME     DATE/TIME STRING
    /// "none"    "none"
    /// "none"    "short"   9:42 AM
    /// "none"    "medium"  9:42:27 AM
    /// "none"    "long"    9:42:27 AM EDT
    /// "none"    "full"    9:42:27 AM Eastern Daylight Time
    /// "short"   "none"    10/10/17
    /// "short"   "short"   10/10/17, 9:42 AM
    /// "short"   "medium"  10/10/17, 9:42:27 AM
    /// "short"   "long"    10/10/17, 9:42:27 AM EDT
    /// "short"   "full"    10/10/17, 9:42:27 AM Eastern Daylight Time
    /// "medium"  "none"    Oct 10, 2017
    /// "medium"  "short"   Oct 10, 2017, 9:42 AM
    /// "medium"  "medium"  Oct 10, 2017, 9:42:27 AM
    /// "medium"  "long"    Oct 10, 2017, 9:42:27 AM EDT
    /// "medium"  "full"    Oct 10, 2017, 9:42:27 AM Eastern Daylight Time
    /// "long"    "none"    October 10, 2017
    /// "long"    "short"   October 10, 2017 at 9:42 AM
    /// "long"    "medium"  October 10, 2017 at 9:42:27 AM
    /// "long"    "long"    October 10, 2017 at 9:42:27 AM EDT
    /// "long"    "full"    October 10, 2017 at 9:42:27 AM Eastern Daylight Time
    /// "full"    "none"    Tuesday, October 10, 2017
    /// "full"    "short"   Tuesday, October 10, 2017 at 9:42 AM
    /// "full"    "medium"  Tuesday, October 10, 2017 at 9:42:27 AM
    /// "full"    "long"    Tuesday, October 10, 2017 at 9:42:27 AM EDT
    /// "full"    "full"    Tuesday, October 10, 2017 at 9:42:27 AM Eastern Daylight Time
    ///
    
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
    
    /// Shows the elapsed time of the date called on.
    var elapsedTimeStamp: String {
        let today = Date()
        let formatter = DateFormatter()
        let calendar = formatter.calendar
        let days = calendar?.dateComponents([.day], from: self, to: today)
        let hours = calendar?.dateComponents([.hour], from: self, to: today)
        let minutes = calendar?.dateComponents([.minute], from: self, to: today)
        let seconds = calendar?.dateComponents([.second], from: self, to: today)
        let dateComp = DateComponents(day: days?.day, hour: hours?.hour, minute: minutes?.minute, second: seconds?.second)
        guard let elapsed = calendar?.date(from: dateComp) else { return "???" }
        formatter.timeStyle = .short
        let dateString = formatter.string(from: self)
        return dateString
    }
    
}


public extension String {
    
    enum KGDateFormatType: String {
        case MM_dd_yy = "MM/dd/yy"
    }
    
    /// Converts a date-0string  to a date object.
    /// - Parameter str: The string of format (MM/dd/yy) to convert.
    /// - Returns: A date object or nil.
    func convertToDate(format: KGDateFormatType) -> Date? {
        let dateFormat = self //"2016-04-14T10:44:00+0000"
        
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current // Locale(identifier: "en_US_POSIX") // set locale to reliable US_POSIX
        dateFormatter.dateFormat = format.rawValue
        
        guard let date = dateFormatter.date(from: dateFormat) else { return nil }
        
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        
        let finalDate = calendar.date(from: components)
        return finalDate
    }
    
}



public extension DateInterval {
    
    /// Formats a DateInterval object to just a standard american format with no time.
    /// - Returns: A string representation of the dateInterval formated.
    var americanDateIntervalFormatter: String {
        let formatter = DateIntervalFormatter()
        formatter.locale = Locale.current
        
        // Configure Date Interval Formatter
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        
        // String From Date Interval
        guard let str = formatter.string(from: self) else { return "???" }
        
        return str
    }
    
}
