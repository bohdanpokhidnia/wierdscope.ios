//
//  FullSwipeNavigationStack.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 20.11.2023.
//

import SwiftUI

struct FullSwipeNavigationStack<Content: View>: View {
    @ViewBuilder var content: Content
    
    @State private var customGesture: UIPanGestureRecognizer = {
        let panGesture = UIPanGestureRecognizer()
        panGesture.name = UUID().uuidString
        panGesture.isEnabled = false
        return panGesture
    }()
    
    var body: some View {
        NavigationStack {
            content
                .background {
                    AttachGestureView(panGesture: $customGesture)
                }
        }
        .environment(\.popGestureID, customGesture.name)
        .onReceive(NotificationCenter.default.publisher(for: .init(customGesture.name ?? ""))) { (info) in
            guard let userInfo = info.userInfo else {
                return
            }
            
            guard let isEnabled = userInfo["isEnabled"] as? Bool else {
                return
            }
            
            customGesture.isEnabled = isEnabled
        }
    }
}

private struct AttachGestureView: UIViewRepresentable {
    @Binding var panGesture: UIPanGestureRecognizer
    
    func makeUIView(context: Context) -> UIView {
        return UIView()
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.02) {
            guard let parentViewController = uiView.parentViewController else {
                return
            }
            guard let navigationController = parentViewController.navigationController else {
                return
            }
            
            if let _ = navigationController.view.gestureRecognizers?.first(where: { $0.name == panGesture.name }) {
                
            } else {
                navigationController.addFullSwipeGesture(panGesture)
            }
        }
    }
}

#Preview {
    FullSwipeNavigationStack {
        NavigationLink(destination: {
            Text("Test")
                .enableFullSwipePop(true)
        }) {
            Text("Test")
        }
    }
}
