//
//  ChangeSignView.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 17.11.2023.
//

import SwiftUI
import SwiftData

struct ChangeSignView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject var viewModel: SettingsViewModel
    @State private var selectedSign: Sign?
    var users: [User]
    
//    @Query private var users: [User]
    
    var body: some View {
        VStack(spacing: 16) {
            OnboardingTitleView(title: "onboarding_choose_sign".localize)
            
            List {
                ForEach(viewModel.signs, id: \.self) { (sign) in
                    SignPickerItem(sign: sign) {
                        guard let user = users.first else { return }
                        
                        print("change on \(sign)")
//                        users.first?.sign = sign
                        
                        user.sign = sign
                        dismiss()
                    }
                }
                .scrollContentBackground(.hidden)
            }
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
    }
    
    func saveUser() {
        
    }
}

#Preview {
    NavigationStack {
        ChangeSignView(users: [User(sign: .cancer)])
            .environmentObject(SettingsViewModel())
//            .modelContainer(for: [User.self], inMemory: true)
    }
}
