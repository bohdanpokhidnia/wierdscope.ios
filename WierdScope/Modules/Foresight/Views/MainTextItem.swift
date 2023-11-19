//
//  MainTextItem.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 14.11.2023.
//

import SwiftUI

struct MainTextItem: View {
    let text: String
    var color: Color = .white
    var size: CGFloat = 26
    var isSecureText: Bool = true
    
    var body: some View {
        if isSecureText {
            SecureView {
                makeText()
            }
        } else {
            makeText()
        }
    }
    
    @ViewBuilder
    private func makeText() -> some View {
        Text(text)
            .font(.IBMPlexSerif(size: size))
            .multilineTextAlignment(.center)
            .padding(.horizontal)
            .foregroundStyle(color)
    }
}

#Preview {
    MainTextItem(text: "Step")
}
