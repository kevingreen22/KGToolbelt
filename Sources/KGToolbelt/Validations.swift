//
//  Validations.swift.swift
//
//  Created by Kevin Green on 12/31/22.
//

import Foundation

public extension String {
    
    /// Validates an email address for correctness.
    func isValidEmail() -> Bool {
        let email = self.trimmingCharacters(in: .whitespaces)
        let firstpart = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
        let serverpart = "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}"
        let emailRegex = firstpart + "@" + serverpart + "[A-Za-z]{2,8}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
    
    /// Validates a password.
    ///
    /// More than 6 characters, with at least one capital, numeric or special character:
    /// "^.*(?=.{6,})(?=.*[A-Z])(?=.*[a-zA-Z])(?=.*\\d)|(?=.*[!#$%&?&]).*$"
    ///
    /// Minimum 8 characters at least 1 Alphabet and 1 Number:
    /// "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
    ///
    /// Minimum 8 characters at least 1 Alphabet, 1 Number and 1 Special Character:
    /// "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$"
    ///
    /// Minimum 8 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet and 1 Number:
    ///
    /// "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$"
    ///
    /// Minimum 8 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet, 1 Number and 1 Special Character:
    ///
    /// "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,}"
    ///
    /// Minimum 8 and Maximum 10 characters at least 1 Uppercase Alphabet, 1 Lowercase Alphabet, 1 Number and 1 Special Character:
    ///
    /// "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&#])[A-Za-z\\d$@$!%*?&#]{8,10}"
    ///
    /// - Parameter style: Optionally set a style of password to use. Defaults to Minimum 8 characters at least 1 Alphabet and 1 Number.
    /// - Returns: True if valid, false otherwise.
    ///
    func isValidPassword(_ style: PasswordStyle = ._8_1Alphabet_and_1Num) -> Bool {
        let pw = self.trimmingCharacters(in: .whitespaces)
        var pattern = ""
        
        switch style {
        case ._6_1Capital_or_1Num_or_1Special:
            pattern = "^.*(?=.{6,})(?=.*[A-Z])(?=.*[a-zA-Z])(?=.*\\d)|(?=.*[!#$%&?&]).*$"
        case ._8_1Alphabet_and_1Num:
            pattern = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{8,}$"
        case ._8_1Alphabet_and_1Num_and_1Special:
            pattern = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$"
        case ._8_1Upper_and_1Lower_and_1Num:
            pattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[a-zA-Z\\d]{8,}$"
        case ._8_1Upper_and_1Lower_and_1Num_and_1Special:
            pattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[d$@$!%*?&#])[A-Za-z\\dd$@$!%*?&#]{8,}"
        case ._min8_Max10_and_1Upper_and_1Lower_and_1Num_and_1Special:
            pattern = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&#])[A-Za-z\\d$@$!%*?&#]{8,10}"
        }
        
        let passwordPredicate = NSPredicate(format: "SELF MATCHES %@", pattern)
        return passwordPredicate.evaluate(with: pw)
    }
    
    enum PasswordStyle {
        case _6_1Capital_or_1Num_or_1Special
        case _8_1Alphabet_and_1Num
        case _8_1Alphabet_and_1Num_and_1Special
        case _8_1Upper_and_1Lower_and_1Num
        case _8_1Upper_and_1Lower_and_1Num_and_1Special
        case _min8_Max10_and_1Upper_and_1Lower_and_1Num_and_1Special
    }
    
    /// Discussion:
    /// ^                         Start anchor
    /// (?=.*[A-Z].*[A-Z])        Ensure string has two uppercase letters.
    /// (?=.*[!@#$&*])            Ensure string has one special case letter.
    /// (?=.*[0-9].*[0-9])        Ensure string has two digits.
    /// (?=.*[a-z].*[a-z].*[a-z]) Ensure string has three lowercase letters.
    /// .{8}                      Ensure string is of length 8.
    /// $                         End anchor.
    /// "^(?=.*[A-Z].*[A-Z])(?=.*[!@#$&*])(?=.*[0-9].*[0-9])(?=.*[a-z].*[a-z].*[a-z]).{8}$"
    
}


