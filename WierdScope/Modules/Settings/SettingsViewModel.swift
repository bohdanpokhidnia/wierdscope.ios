//
//  SettingsViewModel.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 17.11.2023.
//

import SwiftUI

final class SettingsViewModel: ObservableObject {
    @Published var signs: [Sign] = []
    
    func fetchSigns() {
        signs = Sign.allCases.filter { $0 != .none }
    }
    
    func openAppSettings() {
        guard let settingsURL = URL(string: UIApplication.openSettingsURLString) else {
            return
        }
        
        UIApplication.shared.open(settingsURL)
    }
}
