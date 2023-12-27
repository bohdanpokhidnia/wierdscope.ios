//
//  MainView.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 09.11.2023.
//

import SwiftUI
import SwiftData

struct MainView: View {
    @State private var isSharePresented: Bool = false
    var selectedSign: Sign?
    
    @Query private var users: [User]
    
    var body: some View {
        if let sign = selectedSign ?? users.first?.sign {
            GeometryReader { (proxy) in
                FullSwipeNavigationStack {
                    ForesightView(
                        isSharePresented: $isSharePresented,
                        sign: sign,
                        safeArea: proxy.safeAreaInsets
                    )
                    .overlay(alignment: .topTrailing) {
                        VStack(spacing: 8) {
                            NavigationLink {
                                SettingsView()
                                    .enableFullSwipePop(true)
                            } label: {
                                actionLabel(imageSystemName: "gear")
                            }
                            
                            NavigationLink {
                                GalleryView()
                            } label: {
                                actionLabel(imageSystemName: "photo.artframe")
                            }
                        }
                        .padding(.top, proxy.safeAreaInsets.top + 16)
                        .padding(.trailing, 16)
                        .opacity(isSharePresented ? 0.0 : 1.0)
                    }
                    .ignoresSafeArea(.container, edges: .all)
                }
            }
        } else {
            OnboardingView()
        }
    }
    
    @ViewBuilder
    private func actionLabel(imageSystemName: String) -> some View {
        Image(systemName: imageSystemName)
            .font(.title)
            .frame(width: 50, height: 50)
            .scaledToFit()
            .tint(.black)
            .background {
                RoundedRectangle(cornerRadius: 16)
                    .fill(.white)
            }
    }
}

#Preview {
    MainView(selectedSign: .capricorn)
}
