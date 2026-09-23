//
//  CreditCardActivity.swift
//  Budgetary
//
//  Created by Phillip Baker on 11/11/2025.
//

import Foundation

public struct CreditCardActivity: Equatable, Hashable, Sendable {
    let spending: Decimal
    let returns: Decimal
    let totalSpending: Decimal
    let fundedSpending: Decimal
    let paymentsAndReturns: Decimal
    let totalActivity: Decimal
    let transactions: [BudgetTransaction]
}
