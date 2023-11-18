//
//  LoadingView.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 16.11.2023.
//

import SwiftUI

struct LoadingView: View {
    let text: String
    
    var body: some View {
        ProgressView() {
            Text(text)
                .font(.montserrat(size: 16).weight(.medium))
        }
    }
}

#Preview {
    LoadingView(text: "Test text")
}
