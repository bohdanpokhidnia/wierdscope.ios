//
//  UINavigationController.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 12.11.2023.
//

import UIKit

extension UINavigationController {
    func addFullSwipeGesture(_ gesture: UIPanGestureRecognizer) {
        guard let gestureSelector = interactivePopGestureRecognizer?.value(forKey: "targets") else {
            return
        }
        
        gesture.setValue(gestureSelector, forKey: "targets")
        view.addGestureRecognizer(gesture)
    }
}
