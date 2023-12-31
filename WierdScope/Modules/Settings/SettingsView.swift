//
//  SettingsView.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 17.11.2023.
//

import SwiftUI
import SwiftData

struct SettingsView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject private var viewModel = SettingsViewModel()
    @Query private var users: [User]
    
    var body: some View {
        List {
            NavigationLink {
                ChooseSignView(isEditMode: true, users: users)
            } label: {
                settingsListItem(
                    image: Image(uiImage: "ℹ️".toImage(size: CGSize(width: 20, height: 20))!),
                    text: "settings_change_sign".localize
                )
            }
            
            #if DEBUG
            Button(
                action: {
                    viewModel.openAppSettings()
                }, label: {
                    settingsListItem(
                        image: Image(uiImage: "🔠".toImage(size: CGSize(width: 20, height: 20))!),
                        text: "settings_change_language".localize
                    )
                }
            )
            #endif
        }
        .background(.backgroundPrimary)
        .navigationTitle("settings".localize)
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
    
    @ViewBuilder
    private func settingsListItem(image: Image, text: String) -> some View {
        HStack(alignment: .center, spacing: 16) {
            image
            
            Text(text)
                .font(.montserrat(size: 16))
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    FullSwipeNavigationStack {
        SettingsView()
    }
}
