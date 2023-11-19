//
//  AppBannerView.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 14.11.2023.
//

import SwiftUI

struct AppBannerView: View {
    let appName: String
    
    var body: some View {
        HStack(alignment: .center) {
            Button(
                action: {},
                label: {
                    HStack(spacing: 4) {
                        Image(.appBanner)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 30, height: 30)
                        
                        Text(appName)
                            .foregroundStyle(.white)
                            .font(.montserrat(size: 16).weight(.bold))
                    }
                    .padding(.vertical, 12)
                    .padding(.horizontal, 16)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .strokeBorder(style: StrokeStyle(lineWidth: 1), antialiased: true)
                            .foregroundStyle(.white)
                    )
                }
            )
        }
    }
}

#Preview {
    AppBannerView(appName: "Test name")
}
