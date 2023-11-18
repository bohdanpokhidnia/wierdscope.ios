//
//  OnboardingViewModel.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 12.11.2023.
//

import SwiftUI

final class OnboardingViewModel: ObservableObject {
    @Published var signs: [Sign] = []
    
    func fetchSigns() {
        signs = Sign.allCases.filter { $0 != .none }
    }
}
