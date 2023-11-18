//
//  ChooseSignView.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 12.11.2023.
//

import SwiftUI

struct ChooseSignView: View {
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext
    @StateObject private var viewModel = OnboardingViewModel()
    @State var selectedSign: Sign?

    var body: some View {
        VStack(spacing: 16) {
            OnboardingTitleView(title: "onboarding_choose_sign".localize)
            
            List {
                ForEach(viewModel.signs, id: \.self) { (sign) in
                    SignPickerItem(sign: sign) {
                        selectedSign = sign
                        saveUser(sign: sign)
                    }
                }
            }
            .scrollContentBackground(.hidden)
        }
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
        .onAppear {
            viewModel.fetchSigns()
        }
        .navigationDestination(item: $selectedSign) { (selectedSign) in
            MainView(selectedSign: selectedSign)
        }
    }
    
    private func saveUser(sign: Sign) {
        let user = User(sign: sign)
        modelContext.insert(user)
    }
}

#Preview {
    NavigationStack {
        ChooseSignView()
            .modelContainer(for: [User.self], inMemory: true)
    }
}
