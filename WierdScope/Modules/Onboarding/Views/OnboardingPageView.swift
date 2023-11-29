//
//  OnboardingPageView.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 29.11.2023.
//

import SwiftUI

struct OnboardingPageView<Destination: View>: View {
    let navigationBarPadding: Bool
    let title: String
    let titleLineLimit: Int?
    let image: Image
    let destination: Destination
    
    init(
        navigationBarPadding: Bool = false,
        title: String,
        titleLineLimit: Int? = nil,
        image: Image,
        @ViewBuilder destination: (() -> Destination)
    ) {
        self.navigationBarPadding = navigationBarPadding
        self.title = title
        self.titleLineLimit = titleLineLimit
        self.image = image
        self.destination = destination()
    }
    
    var body: some View {
        VStack {
            if navigationBarPadding {
                OnboardingTitleView(title: title, lineLimit: titleLineLimit)
                    .padding(.top, navigationBarHeight + 16)
                    .padding(.horizontal)
            } else {
                OnboardingTitleView(title: title, lineLimit: titleLineLimit)
                    .padding([.top, .horizontal])
            }
            
            image
                .resizable()
                .scaledToFit()
            
            NavigationLink {
                destination
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
    OnboardingPageView(title: "Title", image: Image(.relations)) {
        FeatureView()
    }
}
