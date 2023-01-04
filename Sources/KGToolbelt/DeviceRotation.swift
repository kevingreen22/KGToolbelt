//
//  DeviceRotation.swift
//
//  Created by Kevin Green on 9/2/22.
//
// https://www.hackingwithswift.com/quick-start/swiftui/how-to-detect-device-rotation

import SwiftUI

/// Custom view modifier to track rotation and call an action.
///
/// Important: As of September 3rd, 2021 (Xcode 14.0 beta 1) view modifiers do not work with onReceive() unless you first add onAppear(). Yes, it’s empty, but it acts as a workaround for the problem.
///
/// Example:
///
/// ```
/// struct ContentView: View {
///     @State private var orientation = UIDeviceOrientation.unknown
///     var body: some View {
///         Group {
///             if orientation.isPortrait {
///                 Text("Portrait")
///             } else if orientation.isLandscape {
///                 Text("Landscape")
///             } else if orientation.isFlat {
///                 Text("Flat")
///             } else {
///                 Text("Unknown")
///             }
///         }
///         
///         .onRotate { newOrientation in
///             orientation = newOrientation
///         }
///     }
/// }
/// ```
///
public struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void

    public func body(content: Content) -> some View {
        content
            .onAppear()
            .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                action(UIDevice.current.orientation)
            }
    }
}


public extension View {
    
    var currentOrientation: UIDeviceOrientation {
        return UIDevice.current.orientation
    }
    
    /// Respond to and perform action when the device orientation changes.
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}
