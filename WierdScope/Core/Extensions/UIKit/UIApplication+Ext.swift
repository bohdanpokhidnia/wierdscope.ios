//
//  UIApplication+Ext.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 15.11.2023.
//

import UIKit

extension UIApplication {
    var firstWindow: UIWindow? {
        return (connectedScenes.first as? UIWindowScene)?.keyWindow
    }
}
