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
                
                if let todayForesight = todayForesights(from: foresights, for: sign) {
                    self.foresights = todayForesight
                    state = .loaded
                } else if let lastForesights = lastForesights(from: foresights, for: sign) {
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

// MARK: - Filtering foresights

private extension ForesightViewModel {
    func todayForesights(from foresights: [Foresight], for sign: Sign) -> [String]? {
        let today = Date.now.toString(for: .ddMMyyyy)
        let todayForesights = foresights
            .filter({ $0.sign == sign })
            .first(where: { $0.date.contains(today) })
            .map { $0.foresight }
        return todayForesights
    }
    
    func sortForesightByDate(_ firstForesight: Foresight, _ secondForesight: Foresight) -> Bool {
        let firstForesightDate = firstForesight.date.toDate(for: .ddMMyyyy) ?? .now
        let secondForesightDate = secondForesight.date.toDate(for: .ddMMyyyy) ?? .now
        return firstForesightDate > secondForesightDate
    }
    
    func lastForesights(from foresights: [Foresight], for sign: Sign) -> [String]? {
        let lastForesights = foresights
            .filter({ $0.sign == sign })
            .sorted(by: sortForesightByDate)
            .first
            .map { $0.foresight }
        return lastForesights
    }
}
