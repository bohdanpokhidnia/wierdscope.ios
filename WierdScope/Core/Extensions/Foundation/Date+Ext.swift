//
//  Date+Ext.swift
//  WierdScope
//
//  Created by Bohdan Pokhidnia on 15.11.2023.
//

import Foundation

extension Date {
    func toString(for style: DateFormatStyle) -> String {
        let dateFormatter = CommonDateFormaters.formatter(for: style)
        let stringDate = dateFormatter.string(from: self)
        return stringDate
    }
}
