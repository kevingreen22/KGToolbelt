//
//  ViewSnapshot.swift
//
//  Created by Kevin Green on 12/15/22.
//

import SwiftUI

public extension View {
    
    func snapshot() -> UIImage {
        let controller = UIHostingController(rootView: self)
        let view = controller.view

        let targetSize = controller.view.intrinsicContentSize
        view?.bounds = CGRect(origin: .zero, size: targetSize)
        view?.backgroundColor = .clear

        let renderer = UIGraphicsImageRenderer(size: targetSize)

        return renderer.image { _ in
            view?.drawHierarchy(in: controller.view.bounds, afterScreenUpdates: true)
        }
    }
    
    @available(iOS 16.0, *)
    @MainActor func renderSnapshot(_ completion: (UIImage)->()) -> some View {
        @Environment(\.displayScale) var displayScale
        let renderer = ImageRenderer(content: self)
        
        // make sure and use the correct display scale for this device
        renderer.scale = displayScale
        
        if let uiImage = renderer.uiImage {
            completion(uiImage)
        } else {
            completion(UIImage())
        }
        return self
    }
    
    
    @MainActor func formatViewToString() -> NSAttributedString {
        // create our NSTextAttachment
        let image1Attachment = NSTextAttachment()
        if #available(iOS 16.0, *) {
            image1Attachment.image = self.snapshot()
        } else {
            // Fallback on earlier versions
            image1Attachment.image = self.snapshot()
        }

        // wrap the attachment in its own attributed string so we can append it
        let image1String = NSAttributedString(attachment: image1Attachment)

        return image1String
    }
    
}
