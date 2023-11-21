//
//  GalleryViewModel.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 21.11.2023.
//

import SwiftUI

final class GalleryViewModel: ObservableObject {
    @Published var images: [ImageResource] = []
    
    init() {
        fetchImages()
    }
    
    func fetchImages() {
        images = [
            .beautiful,
            .fear,
            .meditation,
            .relations,
            .relaxation,
        ]
    }
}
