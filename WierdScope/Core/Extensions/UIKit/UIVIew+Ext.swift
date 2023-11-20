//
//  UIVIew+Ext.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 20.11.2023.
//

import UIKit

extension UIView {
    var parentViewController: UIViewController? {
        sequence(first: self) {
            $0.next
        }.first(where: { $0 is UIViewController }) as? UIViewController
    }
}
