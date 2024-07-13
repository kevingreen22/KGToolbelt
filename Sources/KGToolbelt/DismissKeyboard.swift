//
//  KeyboardExtensions.swift
//
//  Created by Kevin Green on 11/16/22.
//

import SwiftUI

public extension View {
    /// The standard UIKit way of dismissing the keyboard.
    func dismissKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

@available(iOS 15.0, *)
public extension View {
    
    /// Adds a done button to the top trailing edge of the keyboard for dismissal. Ideal for phone pad, number pad, or other keyboards without a return/submit key.
    /// - Parameter isFocused: A focusState binding to toggle.
    /// - Parameter action: An optional closure to perform after the button is tapped. Note: the button tap automatically toggles the FocusState binding.
    func keyboardDoneButton(isFocused: FocusState<Bool>.Binding, action: (()->())? = nil) -> some View {
        self
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        isFocused.wrappedValue.toggle()
                        action?()
                    }
                }
            }
            .ignoresSafeArea()
    }
    
    
    /// Dismisses the keyboard when the user taps on the screen outside of the keyboard.
    func dismissKeyboardOnTap(_ isFocused: FocusState<Bool>.Binding) -> some View {
        self
            .onTapGesture {
                isFocused.wrappedValue = false
            }
    }
    
    /// Dismisses the keyboard when the user taps on the screen outside of the keyboard.
    func dismissKeyboardOnTap<T: Hashable>(_ focusedField: FocusState<T?>.Binding) -> some View {
        self
            .onTapGesture {
                focusedField.wrappedValue = nil
            }
    }
    
    
    /// Dismisses the keyboard when the user taps on the screen outside of the keyboard.
    func dismissKeyboardOnTap(isFocused: FocusState<Bool>.Binding) -> some View {
        return self
            .onTapGesture {
                isFocused.wrappedValue = false
            }
    }
    
}



