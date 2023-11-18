//
//  MainTextItem.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 14.11.2023.
//

import SwiftUI

struct MainTextItem: View {
    let text: String
    
    var body: some View {
        Text(text)
            .font(.IBMPlexSerif(size: 26))
            .multilineTextAlignment(.center)
            .padding(.horizontal)
    }
}

#Preview {
    MainTextItem(text: "Step")
}

#Preview {
    MainView()
}
