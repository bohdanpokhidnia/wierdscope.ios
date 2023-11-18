//
//  BoundsAnchorKey.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 14.11.2023.
//

import SwiftUI

struct BoundsAnchorKey: PreferenceKey {
    static var defaultValue: [String: Anchor<CGRect>] = [:]
    
    static func reduce(value: inout [String : Anchor<CGRect>], nextValue: () -> [String : Anchor<CGRect>]) {
        value.merge(nextValue()) { $1 }
    }
}
