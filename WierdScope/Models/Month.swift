//
//  Month.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 07.12.2023.
//

import Foundation

enum Month: String, CaseIterable {
    case january
    case february
    case march
    case april
    case may
    case june
    case july
    case august
    case september
    case october
    case november
    case december
    
    var number: Int {
        guard let index = Self.allCases.firstIndex(of: self) else {
            fatalError("Unknown index")
        }
        let number = index + 1
        return number
    }
    
    var name: String {
        return rawValue.localize
    }
}
