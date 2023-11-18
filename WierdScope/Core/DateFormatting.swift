//
//  DateFormatting.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 15.11.2023.
//

import Foundation

enum DateFormatStyle: String {
    /// 15.11.2023
    case ddMMyyyy = "dd.MM.yyyy"
}

enum DateFormatterFabric {
    static func makeNumberFormatter(for dateStyle: DateFormatStyle) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateStyle.rawValue
        return dateFormatter
    }
}

enum CommonDateFormaters {
    static var formatters = [String: DateFormatter]()

    static func formatter(for style: DateFormatStyle) -> DateFormatter {
       if let formatter = formatters[style.rawValue] {
           return formatter
       } else {
           let formatter = DateFormatterFabric.makeNumberFormatter(for: style)
           formatters[style.rawValue] = formatter
           return formatter
       }
    }
}

