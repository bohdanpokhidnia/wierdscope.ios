//
//  FullSwipeModifier.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 20.11.2023.
//

import SwiftUI

struct FullSwipeModifier: ViewModifier {
    @Environment(\.popGestureID) private var popGestureId
    var isEnabled: Bool
    
    func body(content: Content) -> some View {
        content
            .onChange(of: isEnabled, initial: true) { (oldValue, newValue) in
                guard let popGestureId else {
                    return
                }
                
                NotificationCenter.default.post(name: .init(popGestureId), object: nil, userInfo: ["isEnabled": newValue])
            }
            .onDisappear {
                guard let popGestureId else {
                    return
                }
                
                NotificationCenter.default.post(name: .init(popGestureId), object: nil, userInfo: ["isEnabled": false])
            }
    }
}
