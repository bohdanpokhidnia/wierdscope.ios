//
//  OnboardingTitleView.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 12.11.2023.
//

import SwiftUI

struct OnboardingTitleView: View {
    let title: String
    var lineLimit: Int?
    var scaleFactor: CGFloat = 0.2
    
    var body: some View {
        titleText()
    }
    
    @ViewBuilder
    private func titleText() -> some View {
        if let lineLimit {
            Text(title)
                .font(.montserrat(size: 24).weight(.bold))
                .multilineTextAlignment(.center)
                .lineLimit(lineLimit)
                .minimumScaleFactor(scaleFactor)
        } else {
            Text(title)
                .font(.montserrat(size: 24).weight(.bold))
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    OnboardingTitleView(title: "Test title for debug this view")
}
