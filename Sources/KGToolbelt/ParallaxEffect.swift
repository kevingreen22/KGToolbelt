//
//  ParallaxEffect.swift
//
//  Created by Kevin Green on 10/13/22.
//

import SwiftUI

public extension View {
    
    /// Creates a parallax floating effect. The GeometryProxy passed must encompass the view recieving the effect.
    func parallax(proxy: GeometryProxy, value: CGFloat = 9) -> some View {
        self.offset(y: proxy.frame(in: .global).minY/value)
    }
    
    /// Creates a parallax floating effect.
    func parallax(value: CGFloat = 9) -> some View {
        GeometryReader { proxy in
            self.offset(y: proxy.frame(in: .global).minY/value)
        }
    }
    
}  

