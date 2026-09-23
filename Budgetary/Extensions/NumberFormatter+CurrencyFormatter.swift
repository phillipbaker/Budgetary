//
//  NumberFormatter+CurrencyFormatter.swift
//  Budgetary
//
//  Created by Phillip Baker on 09/12/2025.
//

import Foundation

extension NumberFormatter {
    static let currencyFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        return formatter
    }()
}
