//
//  HarmonyView.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 12.11.2023.
//

import SwiftUI

struct HarmonyView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        OnboardingPageView(
            title: "onboarding_harmony".localize,
            titleLineLimit: 2,
            image: Image(.relaxation)
        ) {
            MakeSelfView()
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
        HarmonyView()
    }
}
