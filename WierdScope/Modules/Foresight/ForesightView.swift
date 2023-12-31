//
//  ForesightView.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 14.11.2023.
//

import SwiftUI
import SwiftData

struct ForesightView: View {
    @Environment(\.scenePhase) private var scenePhase
    @StateObject private var viewModel = ForesightViewModel()
    
    @Binding var isSharePresented: Bool
    let sign: Sign
    let safeArea: EdgeInsets
    
    var body: some View {
        ScrollView(.vertical) {
            switch viewModel.state {
            case .idle, .loading:
                LoadingView(text: "main_loading".localize)
                    .frame(maxWidth: .infinity)
                    .containerRelativeFrame(.vertical)
                
            case .failed(let message):
                ForesightEmpyView(
                    title: message ?? "foresight_no_found_1".localize,
                    subtitle: message == nil ? "foresight_no_found_2".localize : nil
                )
                .frame(maxWidth: .infinity)
                .containerRelativeFrame(.vertical)
                .padding(.horizontal)
                
            case .loaded:
                LazyVStack(spacing: 0) {
                    ForEach(viewModel.foresights, id: \.self) { (foresight) in
                        MainTextItem(text: foresight, isSecureText: !isSharePresented)
                            .anchorPreference(key: BoundsAnchorKey.self, value: .bounds) { (anchor) in
                                return ["foresight": anchor]
                            }
                    }
                    .frame(maxWidth: .infinity)
                    .containerRelativeFrame(.vertical)
                    .overlay(alignment: .bottom) {
                        if !isSharePresented {
                            shareButton()
                                .padding(.horizontal, 16)
                                .padding(.bottom, safeArea.bottom + 16)
                        }
                    }
                    .overlayPreferenceValue(BoundsAnchorKey.self) { (value) in
                        GeometryReader { (proxy) in
                            if let anchor = value["foresight"] {
                                let rect = proxy[anchor]
                                let offsetY = rect.minY + rect.height + 16
                                
                                VStack(spacing: 16) {
                                    Divider()
                                        .padding(.horizontal)
                                    
                                    AppBannerView(appName: viewModel.appName)
                                }
                                .frame(maxWidth: .infinity)
                                .offset(y: offsetY)
                                .opacity(isSharePresented ? 1.0 : 0.0)
                            }
                        }
                    }
                }
            }
        }
        .scrollIndicators(.hidden)
        .scrollTargetBehavior(.paging)
        .background(.backgroundPrimary)
        .navigationBarBackButtonHidden(true)
        .onAppear {
            if isSharePresented {
                didDisplayAd()
            } else {
                viewModel.fetch(for: sign)
            }
        }
        .onChange(of: scenePhase) { (oldValue, _) in
            guard oldValue == .background else {
                return
            }
            
            viewModel.fetch(for: sign)
        }
    }
    
    @ViewBuilder
    func shareButton() -> some View {
        ActionButtonView(
            title: "main_share".localize,
            systemImageName: "square.and.arrow.up"
        ) {
            isSharePresented = true

            viewModel.adProvider.onFailedToLoadAd = {
                self.didDisplayAd()
            }
            
            viewModel.adProvider.showAd()
        }
    }
    
    private func actionSheet(completion: (() -> Void)?) {
        guard let screenshot = takeScreenshot() else { return }
        let items: [Any] = [screenshot]
        let activityViewController = UIActivityViewController(
            activityItems: items,
            applicationActivities: nil
        )
        
        let window = UIApplication.shared.firstWindow
        window?.rootViewController?.present(activityViewController, animated: true, completion: completion)
    }
    
    private func didDisplayAd() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25) {
            actionSheet {
                isSharePresented = false
            }
        }
    }
}

#Preview {
    MainView(selectedSign: .capricorn)
        .modelContainer(for: [User.self], inMemory: true)
}
