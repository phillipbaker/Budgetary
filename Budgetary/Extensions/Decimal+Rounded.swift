//
//  Decimal+Rounded.swift
//  Budgetary
//
//  Created by Phillip Baker on 12/11/2026.
//

import Foundation

extension Decimal {
    func rounded(scale: Int, mode: NSDecimalNumber.RoundingMode = .bankers) -> Decimal {
        var value = self
        var result = Decimal()
        NSDecimalRound(&result, &value, scale, mode)
        return result
    }
}
