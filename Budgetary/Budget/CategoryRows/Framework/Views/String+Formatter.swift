//
//  String+Formatter.swift
//  Budgetary
//
//  Created by Phillip Baker on 17/03/2025.
//

import Foundation

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
}
