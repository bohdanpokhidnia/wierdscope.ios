//
//  OnboardingViewModel.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 12.11.2023.
//

import SwiftUI

final class OnboardingViewModel: ObservableObject {
    @Published var months: [String] = []
    @Published var numberOfDaysInMonth: [String] = []
    @Published var sign: Sign?
    
    func fetchMonths() {
        months = Month.allCases.map { $0.name.capitalized }
    }
    
    func didSelect(monthName: String) {
        guard let month = month(by: monthName) else {
            return
        }
        guard let countDays = countDays(in: month) else {
            return
        }
        let days = Array(1...countDays)
            .map { String($0) }
     
        numberOfDaysInMonth = days
    }
    
    func fetchSign(numberOfDay: String, monthName: String) {
        guard let day = Int(numberOfDay) else {
            return
        }
        guard let month = month(by: monthName) else {
            return
        }
        
        sign = switch month.number {
        case 1: day > 20 ? .aquarius : .capricorn
        case 2: day > 19 ? .pisces : .aquarius
        case 3: day > 21 ? .aries : .pisces
        case 4: day > 20 ? .taurus : .aries
        case 5: day > 21 ? .gemini : .taurus
        case 6: day > 21 ? .cancer : .gemini
        case 7: day > 23 ? .leo : .cancer
        case 8: day > 23 ? .virgo : .leo
        case 9: day > 23 ? .libra : .virgo
        case 10: day > 23 ? .scorpio : .libra
        case 11: day > 22 ? .sagittarius : .scorpio
        case 12: day > 22 ? .capricorn : .sagittarius
        default: .ophiuchus
        }
    }
}

// MARK: - Private Methods

private extension OnboardingViewModel {
    func month(by monthName: String) -> Month? {
        let month = Month.allCases.first(where: { $0.name.capitalized == monthName })
        return month
    }
    
    func countDays(in month: Month) -> Int? {
        let calendar = Calendar.current
        var components = DateComponents()
        components.year = calendar.component(.year, from: .now)
        components.month = month.number
        components.day = 1
        
        guard let date = calendar.date(from: components),
              let range = calendar.range(of: .day, in: .month, for: date) else {
            return nil
        }
        
        let count = range.count
        return count
    }
}
