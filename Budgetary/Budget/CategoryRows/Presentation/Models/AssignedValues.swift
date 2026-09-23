//
//  AssignedValues.swift
//  Budgetary
//
//  Created by Phillip Baker on 25/03/2025.
//

import Foundation

struct AssignedValues: Equatable {
    var primary: Decimal
    var secondary: Decimal
    var operation: AmountOperation?
    var lastCommitted: Decimal
    var primaryIsNegative: Bool
    
    init(
        primary: Decimal,
        secondary: Decimal,
        operation: AmountOperation? = nil,
        lastCommitted: Decimal,
        primaryIsNegative: Bool
    ) {
        self.primary = primary
        self.secondary = secondary
        self.operation = operation
        self.lastCommitted = lastCommitted
        self.primaryIsNegative = primaryIsNegative
    }
}
