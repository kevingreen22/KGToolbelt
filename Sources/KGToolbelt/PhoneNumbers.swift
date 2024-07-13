//
//  PhoneNumbers.swift
//  
//  Created by Kevin Green on 12/31/22.
//

import Foundation

public extension String {
    
    /// Formats, in-place, a 10 digit phone number(US phone numbers only) string to automatically insert area code parentheses "(xxx)" and dash "-" between the exchange and subscriber number groups.
    mutating func phoneNumberFormated() {
        self = self.replacingOccurrences(of: "(", with: "")
            .replacingOccurrences(of: ")", with: "")
            .replacingOccurrences(of: "-", with: "")
        let srt = self.startIndex
        
        switch self.count {
        case 1,2: self = "(\(self)"
        case 3: self = "(\(self))"
        case 4,5:
            self.insert("(", at: srt)
            self.insert(")", at: self.index(after: self.index(srt, offsetBy: 3)))
        case 6,7,8,9,10:
            self.insert("(", at: srt)
            self.insert(")", at: self.index(after: self.index(srt, offsetBy: 3)))
            self.insert("-", at: self.index(after: self.index(srt, offsetBy: 7)))
            
        default:
            break
        }
    }
    
    
    /// Formats a 10 digit phone number string to automatically insert area code parentheses "(xxx)" and dash "-" between the exchange and subscriber number groups.
    /// - return: A new string.
    mutating func phoneNumberFormated() -> String {
        self = self.replacingOccurrences(of: "(", with: "")
            .replacingOccurrences(of: ")", with: "")
            .replacingOccurrences(of: "-", with: "")
        let srt = self.startIndex
        
        switch self.count {
        case 1,2: self = "(\(self)"
        case 3: self = "(\(self))"
        case 4,5:
            self.insert("(", at: srt)
            self.insert(")", at: self.index(after: self.index(srt, offsetBy: 3)))
        case 6,7,8,9,10:
            self.insert("(", at: srt)
            self.insert(")", at: self.index(after: self.index(srt, offsetBy: 3)))
            self.insert("-", at: self.index(after: self.index(srt, offsetBy: 7)))
            
        default:
            break
        }
        return self
    }
    
    
    /// Validates a phone number.
    ///
    /// Regardless of the way the phone number is entered, the capture groups can be used to breakdown the phone number so you can process it in your code.
    ///
    /// Group1: Country Code (ex: 1 or 86)
    ///
    /// Group2: Area Code (ex: 800)
    ///
    /// Group3: Exchange (ex: 555)
    ///
    /// Group4: Subscriber Number (ex: 1234)
    ///
    /// Group5: Extension (ex: 5678)
    ///
    ///```
    /// ^\s*                // Line start, match any whitespaces at the beginning if any.
    /// (?:\+?(\d{1,3}))?   // GROUP 1: The country code. Optional.
    /// [-. (]*             // Allow certain non numeric characters that may appear between the Country Code and the Area Code.
    /// (\d{3})             // GROUP 2: The Area Code. Required.
    /// [-. )]*             // Allow certain non numeric characters that may appear between the Area Code(zip code, postal code) and the Exchange number.
    /// (\d{3})             // GROUP 3: The Exchange number. Required.
    /// [-. ]*              // Allow certain non numeric characters that may appear between the Exchange number and the Subscriber number.
    /// (\d{4})             // Group 4: The Subscriber Number. Required.
    /// (?: *x(\d+))?       // Group 5: The Extension number. Optional.
    /// \s*$                // Match any ending whitespaces if any and the end of string.
    ///```
    ///
    /// Matching examples:
    ///
    /// 18005551234
    ///
    /// 1 800 555 1234
    ///
    /// +1 800 555-1234
    ///
    /// +86 800 555 1234
    ///
    /// 1-800-555-1234
    ///
    /// 1 (800) 555-1234
    ///
    /// (800)555-1234
    ///
    /// (800) 555-1234
    ///
    /// (800)5551234
    ///
    /// 800-555-1234
    ///
    /// 800.555.1234
    ///
    /// 800 555 1234x5678
    ///
    /// 8005551234 x5678
    ///
    /// 1    800    555-1234
    ///
    /// 1----800----555-1234
    ///
    func isValidPhoneNumber() -> Bool {
        let phone = self.trimmingCharacters(in: .whitespaces)
        let phone_regex = "^\\s*(?:\\+?(\\d{1,3}))?[-. (]*(\\d{3})[-. )]*(\\d{3})[-. ]*(\\d{4})(?: *x(\\d+))?\\s*$"
        let phonePredicate = NSPredicate(format: "SELF MATCHES %@", phone_regex)
        return  phonePredicate.evaluate(with: phone)
    }
    
}

