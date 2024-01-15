//
//  ForesightViewModel.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 10.11.2023.
//

import SwiftUI

enum DataState {
    case idle
    case loading
    case failed(message: String?)
    case loaded
}

final class ForesightViewModel: ObservableObject {
    @Published private(set) var state: DataState = .idle
    @Published private(set) var foresights: [String] = []
    
    private var firestoreService = FirestoreService()
    let adProvider = AdProvider()
    
    var appName: String {
        if let bundleDisplayName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String {
            return bundleDisplayName
        } else {
            return "Unknown app name"
        }
    }
    
    @MainActor
    func fetch(for sign: Sign) {
        state = .loading
        
        Task {
            do {
                let foresights = try await firestoreService.fetchItems(Foresight.self, from: .horoscope)
                
                if let todayForesight = firestoreService.filter(foresights, at: .today)
                    .first(where: { $0.sign == sign })
                    .map({ $0.foresight })
                {
                    self.foresights = todayForesight
                    state = .loaded
                } else if let lastForesights = firestoreService.filter(foresights, at: .last)
                    .first(where: { $0.sign == sign })
                    .map({ $0.foresight })
                {
                    self.foresights = lastForesights
                    state = .loaded
                } else {
                    state = .failed(message: nil)
                }
            } catch FirestoreError.emptyCollection {
                state = .failed(message: nil)
            } catch {
                print("error \(error)")
                
                state = .failed(message: error.localizedDescription)
            }
        }
    }
}
