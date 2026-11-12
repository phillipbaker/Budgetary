//
//  Array+BudgetTransaction.swift
//  Budgetary
//
//  Created by Phillip Baker on 12/11/2026.
//

import Foundation

extension [BudgetTransaction] {
    var netAmount: Decimal { reduce(0) { $0 + $1.amount.signedValue } }
}
