//
//  LimitCharacterLength.swift
//
//  Created by Kevin Green on 12/2/23.
//

import SwiftUI
import Combine

public extension TextField {
    
    /// Keeps text length to a limited number of characters.
    func limitCharacterLength(limit: Int, text: Binding<String>) -> some View {
        self
            .onReceive(Just(text), perform: { _ in
                if text.wrappedValue.count > limit {
                    text.wrappedValue = String(text.wrappedValue.prefix(limit))
                }
            })
    }
    
    /// Keeps text length to a limited number of characters.
    func limitCharacterLength(limit: Int, value: Binding<Int>) -> some View {
        self
            .onReceive(Just(value), perform: { _ in
                let count = String(value.wrappedValue).count
                if count > limit {
                    let limitedStr = String(value.wrappedValue).prefix(limit)
                    guard let limitedInt = Int(limitedStr) else { return }
                    value.wrappedValue = limitedInt
                }
            })
    }
    
    /// Selects the text when this view is focused. An optional closure is available.
    func selectAllTextOnBeginEditing(_ action: (()->())? = nil) -> some View {
        self.modifier(SelectAllTextOnBeginEditingModifier(action: { action?() }))
    }
}


private struct SelectAllTextOnBeginEditingModifier: ViewModifier {
    var action: (()->())?
    
    public func body(content: Content) -> some View {
        content
            .onReceive(NotificationCenter.default.publisher(
                for: UITextField.textDidBeginEditingNotification)) { output in
                    DispatchQueue.main.async {
                        UIApplication.shared.sendAction(#selector(UIResponder.selectAll(_:)), to: nil, from: nil, for: nil)
                        action?()
                    }
                }
        }
}

