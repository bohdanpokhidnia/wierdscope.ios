//
//  FeatureView.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 12.11.2023.
//

import SwiftUI

struct FeatureView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        OnboardingPageView(title: "onboarding_feature".localize, image: Image(.relations)) {
            HarmonyView()
        }
        .frame(maxWidth: .infinity)
        .containerRelativeFrame(.vertical)
        .background(.backgroundPrimary)
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Button(action: {
                    dismiss()
                }) {
                    Image(systemName: "chevron.backward")
                        .tint(Color(.actionButtonBackground))
                }
            }
        }
    }
}

#Preview {
    NavigationStack {
        FeatureView()
    }
}
