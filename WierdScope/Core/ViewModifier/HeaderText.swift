//
//  HeaderText.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 08.12.2023.
//

import SwiftUI

struct HeaderText: ViewModifier {
    let header: String
    
    init(_ header: String) {
        self.header = header
    }
    
    func body(content: Content) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(header)
                .font(.montserrat(size: 12).weight(.bold))
                .padding(.horizontal, 6)
                .foregroundStyle(.gray)
            
            content
        }
    }
}
