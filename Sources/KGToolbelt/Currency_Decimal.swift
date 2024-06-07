//
//  Currency_Decimal.swift
//
//  Created by Kevin Green on 11/25/22.
//

import Foundation

// MARK: Locale Extension
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



// MARK: String Extension
public extension String {
    
    enum TypeOfFormat {
        case currency
        case percentage
    }
    
    /// Converts a number-string to a Float.
    /// - Parameters:
    ///   - format: A TypeOfFormat to convert to.
    /// - Returns: A Float or nil.
    mutating func convertToFloat(format: TypeOfFormat) -> Float? {
        if self.first == "$" { self = String(self.dropFirst()) }
        if self.last == "%" { self = String(self.dropLast()) }
        guard let strAsFloat = Float(self) else { return nil }
        var formattedStr = ""
        switch format {
        case .currency:
            formattedStr = String(format: "%.2f", strAsFloat)
        case .percentage:
            formattedStr = String(format: "%.1f", strAsFloat)
        }
        
        if let number = Float(formattedStr) {
            return number
        }
        return nil
    }
    
}


public enum DecimalPlace: Int {
    case ones = 1
    case tens = 10
    case hundreds = 100
    case thousands = 1000
    case tenThousands = 10000
}


// MARK: Float Extension
public extension Float {
    
    func asDecimal(by place: DecimalPlace) -> Float {
        return self / Float(place.rawValue)
    }
    
    func asDecimalFromContext() -> Float {
        var decimal: Float = 0.0
        switch self {
        case 0...9:
            decimal = self / 10
        case 10...99:
            decimal = self / 100
        case 100...999:
            decimal = self / 1000
        case 1000...9999:
            decimal = self / 10000
        case 10000...99999:
            decimal = self / 100000
        default:
            break
        }
        
        return decimal
    }
    
    func roundTo(decimal places: Int) -> Float {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = places
        formatter.minimumFractionDigits = places
        let numStr = formatter.string(from: NSNumber(value: self))
        return Float(numStr!)!
    }
    
    
}


// MARK: Double Extension
public extension Double {
    
    enum TypeOfFormat {
        case numerical
        case currency
        case percentage
    }
   
    func formated(type: TypeOfFormat) -> String {
        let formatter = NumberFormatter()
        switch type {
        case .numerical:
            formatter.locale = Locale.current
            formatter.numberStyle = .decimal
            formatter.maximumFractionDigits = 2
        case .currency:
            formatter.locale = Locale.current
            formatter.numberStyle = .currency
            formatter.maximumFractionDigits = 2
            formatter.currencySymbol = Locale.current.currencySymbol
        case .percentage:
            formatter.locale = Locale.current
            formatter.numberStyle = .percent
            return formatter.string(from: NSNumber(value: self)) ?? "??"
        }
        
        return formatter.string(from: NSNumber(value: self / 0.1)) ?? "??"
    }
    
    
    func asDecimal(by place: DecimalPlace) -> Double {
        return self / Double(place.rawValue)
    }
    
    func asDecimalFromContext() -> Double {
        var decimal: Double = 0.0
        switch self {
        case 0...9:
            decimal = self / 10
        case 10...99:
            decimal = self / 100
        case 100...999:
            decimal = self / 1000
        case 1000...9999:
            decimal = self / 10000
        case 10000...99999:
            decimal = self / 100000
        default:
            break
        }
        
        return decimal
    }
}


// MARK: CGFloat Extension
public extension CGFloat {
    
    func asDecimal(by place: DecimalPlace) -> CGFloat {
        return self / CGFloat(place.rawValue)
    }
    
    func asDecimalFromContext() -> CGFloat {
        var decimal: CGFloat = 0.0
        switch self {
        case 0...9:
            decimal = self / 10
        case 10...99:
            decimal = self / 100
        case 100...999:
            decimal = self / 1000
        case 1000...9999:
            decimal = self / 10000
        case 10000...99999:
            decimal = self / 100000
        default:
            break
        }
        
        return decimal
    }
}
