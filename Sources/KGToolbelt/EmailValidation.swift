//
//  EmailValidation.swift.swift
//
//  Created by Kevin Green on 12/31/22.
//

import Foundation

public extension String {
    
    /// Validates an email address.
    /// - Returns: True if valid, false otherwise.
    func isValidEmail() -> Bool {
        let email = self.trimmingCharacters(in: .whitespaces)
        let firstpart = "[A-Z0-9a-z]([A-Z0-9a-z._%+-]{0,30}[A-Z0-9a-z])?"
        let serverpart = "([A-Z0-9a-z]([A-Z0-9a-z-]{0,30}[A-Z0-9a-z])?\\.){1,5}"
        let emailRegex = firstpart + "@" + serverpart + "[A-Za-z]{2,8}"
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPredicate.evaluate(with: email)
    }
    
}
