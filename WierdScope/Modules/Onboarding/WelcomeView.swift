//
//  WelcomeView.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 12.11.2023.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        Color(.backgroundPrimary)
            .ignoresSafeArea(.all)
            .overlay(alignment: .top) {
                OnboardingTitleView(title: "onboarding_welcome".localize)
                    .padding([.top, .horizontal])
            }
            .overlay(alignment: .bottom) {
                NavigationLink {
                    StarsView()
                } label: {
                    Text("continue".localize)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
                .buttonStyle(ActionButtonStyle())
            }
    }
}

#Preview {
    WelcomeView()
}
