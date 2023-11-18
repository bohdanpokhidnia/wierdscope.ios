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
                NavigationStack {
                    ForesightView(
                        isSharePresented: $isSharePresented,
                        sign: sign,
                        safeArea: proxy.safeAreaInsets
                    )
                    .overlay(alignment: .topTrailing) {
                        NavigationLink {
                            SettingsView(sign: sign)
                        } label: {
                            Image(systemName: "gear")
                                .font(.title)
                                .frame(width: 50, height: 50)
                                .scaledToFit()
                                .tint(.black)
                                .background {
                                    RoundedRectangle(cornerRadius: 16)
                                        .fill(.white)
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
}

#Preview {
    MainView(selectedSign: .capricorn)
}
