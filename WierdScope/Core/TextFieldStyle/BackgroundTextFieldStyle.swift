//
//  BackgroundTextFieldStyle.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 08.12.2023.
//

import SwiftUI

struct BackgroundTextFieldStyle: TextFieldStyle {
    let backgroundColor: Color
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .frame(height: 50)
            .padding(.horizontal, 16)
            .background(.black)
            .foregroundStyle(backgroundColor)
            .cornerRadius(12)
    }
}
