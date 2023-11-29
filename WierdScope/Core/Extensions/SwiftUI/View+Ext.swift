//
//  View+Ext.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 15.11.2023.
//

import SwiftUI

extension View {
    var navigationBarHeight: CGFloat {
        let height = UINavigationController().navigationBar.frame.height
        return height
    }
    
    func takeScreenshot() -> UIImage? {
        let window = UIApplication.shared.firstWindow
        let renderer = UIGraphicsImageRenderer(bounds: window?.bounds ?? UIScreen.main.bounds)
        let image = renderer.image { (context) in
            window?.drawHierarchy(in: window?.bounds ?? UIScreen.main.bounds, afterScreenUpdates: true)
        }
        return image
    }
    
    @ViewBuilder
    func enableFullSwipePop(_ isEnabled: Bool) -> some View {
        self
            .modifier(FullSwipeModifier(isEnabled: isEnabled))
    }
}
