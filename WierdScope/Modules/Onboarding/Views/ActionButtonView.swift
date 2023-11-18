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
    let action: (() -> Void)?
    
    var body: some View {
        if let action {
            if let systemImageName {
                Button(title, action: action)
                    .buttonStyle(ActionButtonStyle(systemImageName: systemImageName))
            } else {
                Button(title, action: action)
                    .buttonStyle(ActionButtonStyle())
            }
        } else {
            actionLabel()
        }
    }
    
    @ViewBuilder
    private func actionLabel() -> some View {
        Text(title)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 12)
            .foregroundStyle(.black)
            .font(.montserrat(size: 24).weight(.medium))
            .background {
                RoundedRectangle(cornerRadius: 14, style: .continuous)
                    .fill(isEnabled ? Color(.actionButtonBackground) : .gray.opacity(0.6))
            }
    }
}

struct ActionButtonStyle: ButtonStyle {
    @Environment(\.isEnabled) private var isEnabled
    var isFullWidth: Bool = true
    var cornerRadius: CGFloat = 14.0
    var systemImageName: String?
    
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
        .background {
            RoundedRectangle(cornerRadius: cornerRadius, style: .continuous)
                .fill(isEnabled ? Color(.actionButtonBackground) : .gray.opacity(0.6))
                .opacity(configuration.isPressed ? 0.8 : 1.0)
                .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
                .animation(.easeIn, value: configuration.isPressed)
        }
    }
}

#Preview {
    ActionButtonView(
        title: "continue".localize,
        action: { print("did tap on action button") }
    )
}

#Preview {
    ActionButtonView(
        title: "continue".localize,
        systemImageName: "person",
        action: { print("did tap on action button") }
    )
}
