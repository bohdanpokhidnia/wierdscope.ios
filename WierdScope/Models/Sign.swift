//
//  Sign.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 09.11.2023.
//

import Foundation

enum Sign: String, CaseIterable, FallbackCase {
    static var fallbackCase: Sign = .none
    
    case aries
    case taurus
    case gemini
    case cancer
    case leo
    case virgo
    case libra
    case scorpio
    case sagittarius
    case capricorn
    case aquarius
    case pisces
    case ophiuchus
    case none
    
    var identifier: String {
        return self.rawValue.capitalized
    }
    
    var name: String {
        switch self {
        case .aries: "Овен"
        case .taurus: "Телець"
        case .gemini: "Близнюки"
        case .cancer: "Рак"
        case .leo: "Лев"
        case .virgo: "Діва"
        case .libra: "Терези"
        case .scorpio: "Скорпіон"
        case .sagittarius: "Стрілець"
        case .capricorn: "Козеріг"
        case .aquarius: "Водолій"
        case .pisces: "Риби"
        case .ophiuchus: "Змієносець"
        case .none: "Error Sign"
        }
    }
    
    var emoji: String {
        switch self {
        case .aries: "♈"
        case .taurus: "♉"
        case .gemini: "♊"
        case .cancer: "♋"
        case .leo: "♌"
        case .virgo: "♍"
        case .libra: "♎"
        case .scorpio: "♏"
        case .sagittarius: "♐"
        case .capricorn: "♑"
        case .aquarius: "♒"
        case .pisces: "♓"
        case .ophiuchus: "\u{2650}\u{fe0f}"
        case .none: "👹"
        }
    }
    
    var formattedName: String {
        [name, emoji].joined(separator: " ")
    }
    
    init(from decoder: Decoder) throws {
        let value = try decoder.singleValueContainer().decode(String.self)
        self = Self.allCases.first(where: { $0.identifier == value || $0.rawValue == value }) ?? .fallbackCase
    }
}
