//
//  WelcomeView.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 12.11.2023.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        OnboardingPageView(
            navigationBarPadding: true,
            title: "onboarding_welcome".localize,
            image: Image(.meditation)
        ) {
            FeatureView()
        }
        .frame(maxWidth: .infinity)
        .containerRelativeFrame(.vertical)
        .background(.backgroundPrimary)
    }
}

#Preview {
    NavigationStack {
        WelcomeView()
    }
}
