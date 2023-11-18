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
        Color(.backgroundPrimary)
            .ignoresSafeArea(.all)
            .overlay(alignment: .top) {
                OnboardingTitleView(title: "onboarding_harmony".localize)
                    .padding([.top, .horizontal])
            }
            .overlay(alignment: .bottom) {
                NavigationLink {
                    MakeSelfView()
                } label: {
                    Text("continue".localize)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
                .buttonStyle(ActionButtonStyle())
            }
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
