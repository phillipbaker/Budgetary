//
//  String+Formatter.swift
//  Budgetary
//
//  Created by Phillip Baker on 17/03/2025.
//

import Foundation

// Figure out how this fits with mappers and/or just putting Decimals in views and using .formatted so not converting back and forth all the time...

extension String {
    static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.locale = .current
        return formatter
    }()
    
    var decimalValue: Decimal? {
        let rawValue = self.trimmingCharacters(in: .whitespacesAndNewlines)
        let cleanedValue = rawValue.replacingOccurrences(of: Self.formatter.currencySymbol, with: "")
        return Self.formatter.number(from: cleanedValue)?.decimalValue
    }
    
//    func decimalValue() -> Decimal? {
//        let rawValue = self.trimmingCharacters(in: .whitespacesAndNewlines)
//
//        guard !rawValue.isEmpty else { return nil }
//
//        let cleanedValue = rawValue.replacingOccurrences(
//            of: Self.formatter.currencySymbol,
//            with: ""
//        )
//
//        guard let number = Self.formatter.number(from: cleanedValue) else {
//            return nil
//        }
//
//        return number.decimalValue
//    }
}
