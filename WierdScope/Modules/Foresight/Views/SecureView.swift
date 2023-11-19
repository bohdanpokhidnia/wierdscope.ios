//
//  SecureView.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 19.11.2023.
//

import SwiftUI

struct SecureView<Content: View>: View {
    var content: Content
    @State private var hostingController: UIHostingController<Content>?
    
    init(@ViewBuilder content: @escaping (() -> Content)) {
        self.content = content()
    }
    
    var body: some View {
        SecureUIView(hostingController: $hostingController)
            .overlay {
                GeometryReader { (proxy) in
                    let size = proxy.size
                    
                    Color.clear
                        .preference(key: SizeKey.self, value: size)
                        .onPreferenceChange(SizeKey.self) { (size) in
                            guard size != .zero else {
                                return
                            }
                            
                            if hostingController == nil {
                                hostingController = UIHostingController(rootView: content)
                                hostingController?.view.backgroundColor = .clear
                                hostingController?.view.tag = 1009
                            }
                            
                            hostingController?.view.frame = .init(origin: .zero, size: size)
                        }
                }
            }
    }
}

private struct SecureUIView<Content: View>: UIViewRepresentable {
    @Binding var hostingController: UIHostingController<Content>?
    
    func makeUIView(context: Context) -> UIView {
        let textField = UITextField()
        textField.isSecureTextEntry = true
        
        guard let textLayoutView = textField.subviews.first else {
            return UIView()
        }
        return textLayoutView
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        guard let hostingController else {
            return
        }
        
        guard !uiView.subviews.contains(where: { $0.tag == 1009 }) else {
            return
        }
        
        uiView.addSubview(hostingController.view)
    }
}

#Preview {
    SecureView {
        Text("Test")
    }
}
