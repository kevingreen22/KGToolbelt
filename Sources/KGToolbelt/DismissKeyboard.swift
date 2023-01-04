//
//  DismissKeyboard.swift
//
//  Created by Kevin Green on 11/16/22.
//

import SwiftUI
import UIKit

#if canImport(UIKit)
public extension View {
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
