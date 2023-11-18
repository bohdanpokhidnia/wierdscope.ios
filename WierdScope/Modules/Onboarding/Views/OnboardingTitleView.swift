//
//  OnboardingTitleView.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 12.11.2023.
//

import SwiftUI

struct OnboardingTitleView: View {
    let title: String
    
    var body: some View {
        Text(title)
            .font(.montserrat(size: 24).weight(.bold))
            .multilineTextAlignment(.center)
    }
}

#Preview {
    OnboardingTitleView(title: "Test title for debug this view")
}
