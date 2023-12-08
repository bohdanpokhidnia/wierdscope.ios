//
//  ActionButtonView.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 12.11.2023.
//

import SwiftUI

struct ActionButtonView: View {
    @Environment(\.isEnabled) private var isEnabled
    let title: String
    var systemImageName: String?
    let action: (() -> Void)
    
    var body: some View {
        Button(title, action: action)
            .buttonStyle(ActionButtonStyle(systemImageName: systemImageName))
    }
}

struct ActionButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    var isFullWidth: Bool = true
    var systemImageName: String?
    var normalColor: Color = .actionButtonBackground
    var disabledColor: Color = .gray.opacity(0.6)
    
    func makeBody(configuration: Configuration) -> some View {
        HStack(spacing: 16) {
            configuration.label
                .foregroundStyle(.black.opacity(configuration.isPressed ? 0.8 : 1.0))
                .font(.montserrat(size: 24).weight(.medium))
            
            if let systemImageName {
                Image(systemName: systemImageName)
                    .font(.system(size: 24))
                    .foregroundStyle(.black)
            }
        }
        .frame(maxWidth: isFullWidth ? .infinity : nil)
        .padding(.vertical, 12)
        .background(isEnabled ? normalColor : disabledColor)
        .clipShape(Capsule())
        .opacity(configuration.isPressed ? 0.8 : 1.0)
        .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
        .animation(.linear, value: configuration.isPressed)
    }
}

#Preview {
    ActionButtonView(
        title: "continue".localize,
        action: { print("did tap on action button") }
    )
    .disabled(false)
}

#Preview {
    ActionButtonView(
        title: "continue".localize,
        systemImageName: "person",
        action: { print("did tap on action button") }
    )
}
