//
//  OnboardingView.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 12.11.2023.
//

import SwiftUI

struct OnboardingView: View {
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            WelcomeView()
        }
    }
}

#Preview {
    OnboardingView()
}
