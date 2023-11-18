//
//  ForesightEmpyView.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 18.11.2023.
//

import SwiftUI

struct ForesightEmpyView: View {
    let title: String
    var subtitle: String?
    
    var body: some View {
        VStack(spacing: 16) {
            Image(uiImage: "✨".toImage(size: CGSize(width: 40, height: 40))!)
                .resizable()
                .frame(width: 40, height: 40)
                .scaledToFit()
            
            Text(title)
                .font(.montserrat(size: 16).weight(.medium))
                .multilineTextAlignment(.center)
            
            if let subtitle {
                Divider()
                
                Text(subtitle)
                    .font(.montserrat(size: 16).weight(.medium))
                    .multilineTextAlignment(.center)
            }
        }
    }
}

#Preview {
    ForesightEmpyView(title: "Title", subtitle: "Subtitle")
}
