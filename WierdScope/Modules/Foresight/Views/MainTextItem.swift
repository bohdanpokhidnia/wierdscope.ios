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
    
    var body: some View {
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
