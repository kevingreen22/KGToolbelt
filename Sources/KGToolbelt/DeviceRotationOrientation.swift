//
//  DeviceRotationOrientation.swift
//
//  Created by Kevin Green on 9/2/22.
//
// https://www.hackingwithswift.com/quick-start/swiftui/how-to-detect-device-rotation

import SwiftUI

// MARK: Rotation
/// Custom view modifier to track rotation and call an action.
///
/// Important: As of September 3rd, 2021 (Xcode 14.0 beta 1) view modifiers do not work with onReceive() unless you first add onAppear(). Yes, it’s empty, but it acts as a workaround for the problem.
///
/// Example:
///
/// ```swift
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
///         .onRotate { newOrientation in
///             orientation = newOrientation
///         }
///     }
/// }
/// ```
///
public struct DeviceRotationViewModifier: ViewModifier {
    let action: (UIDeviceOrientation) -> Void
    
    public init(action: @escaping (UIDeviceOrientation) -> Void) {
        self.action = action
    }

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
    
    /// Respond to and perform an action when the device orientation changes.
    func onRotate(perform action: @escaping (UIDeviceOrientation) -> Void) -> some View {
        self.modifier(DeviceRotationViewModifier(action: action))
    }
}


// MARK: Orientation
public extension View {
    
    /// Forces the view to rotate to the spcecified orientation.
    /// Add this line in the @main app file: @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    /// - Parameter orientation: The iPhone orientation to show.
    @ViewBuilder func forceRotation(orientation: UIInterfaceOrientationMask) -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            let currentOrientation = AppDelegate.orientationLock
            self.onAppear() {
                AppDelegate.orientationLock = orientation
            }.onDisappear() {
                AppDelegate.orientationLock = currentOrientation
            } // <- Reset orientation to previous setting
        } else {
            self
        }
    }
    
    /// Locks a view to a specified orientation.
    /// Add this line in the @main app file: @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    /// - Parameter orientation: The orientation to lock the view in.
    @ViewBuilder func lockOrientation(to orientation: UIInterfaceOrientationMask) -> some View {
        if UIDevice.current.userInterfaceIdiom == .phone {
            self.onAppear() {
                AppDelegate.orientationLock = orientation
            }
        } else {
            self
        }
    }
    
}

public enum Orientation: Int, CaseIterable {
    case landscapeLeft
    case landscapeRight
    case portrait
    
    var title: String {
        switch self {
        case .landscapeLeft:
            return "LandscapeLeft"
        case .landscapeRight:
            return "LandscapeRight"
        case .portrait:
            return "Portrait"
        }
    }
    
    var mask: UIInterfaceOrientationMask {
        switch self {
        case .landscapeLeft:
            return .landscapeLeft
        case .landscapeRight:
            return .landscapeRight
        case .portrait:
            return .portrait
        }
    }
}

public class AppDelegate: NSObject, UIApplicationDelegate {

    static var orientationLock = UIInterfaceOrientationMask.portrait {
        didSet {
            if #available(iOS 16.0, *) {
                UIApplication.shared.connectedScenes.forEach { scene in
                    if let windowScene = scene as? UIWindowScene {
                        windowScene.requestGeometryUpdate(.iOS(interfaceOrientations: orientationLock))
                        windowScene.windows.first?.rootViewController?.setNeedsUpdateOfSupportedInterfaceOrientations()
                    }
                }
                
            } else {
                // fallback on old implementations
                if orientationLock == .landscape {
                    UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
                } else {
                    UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
                }
            }
        }
    }
    
}

