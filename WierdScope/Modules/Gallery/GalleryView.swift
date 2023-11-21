//
//  GalleryView.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 21.11.2023.
//

import SwiftUI

struct GalleryView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject private var viewModel = GalleryViewModel()
    
    var body: some View {
        TabView {
            ForEach(viewModel.images, id: \.self) { (image) in
                Image(image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            }
            .frame(maxHeight: .infinity)
            .containerRelativeFrame(.horizontal)
        }
        .tabViewStyle(.page)
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
    }
}

#Preview {
    NavigationStack {
        GalleryView()
    }
}
