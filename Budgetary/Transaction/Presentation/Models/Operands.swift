//
//  Operands.swift
//  Budgetary
//
//  Created by Phillip Baker on 27/05/2025.
//

import Foundation

struct Operands: Equatable, Hashable {
    var primary: Decimal
    var secondary: Decimal
    var operation: AmountOperation?
    var primaryIsNegative: Bool
    
    init(
        primary: Decimal = 0,
        secondary: Decimal = 0,
        operation: AmountOperation? = nil,
        primaryIsNegative: Bool = true
    ) {
        self.primary = primary
        self.secondary = secondary
        self.operation = operation
        self.primaryIsNegative = primaryIsNegative
    }
}

enum AmountOperation: Equatable, Hashable {
    case add
    case subtract
}
