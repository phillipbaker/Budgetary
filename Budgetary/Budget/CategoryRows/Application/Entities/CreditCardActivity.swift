//
//  CreditCardActivity.swift
//  Budgetary
//
//  Created by Phillip Baker on 11/11/2025.
//

import Foundation

public struct CreditCardActivity: Equatable, Hashable, Sendable {
    // Stored
    let spending: Decimal        // regular payees, outflows (magnitude)
    let returns: Decimal         // regular payees, inflows (magnitude)
    let returnsApplied: Decimal  // net refunds by category, up to what the card owes
    let fundedSpending: Decimal  // net spending covered by category budgets
    let payments: Decimal        // transfer payees, inflows (magnitude)
    let transfersOut: Decimal    // transfer payees, outflows (magnitude)
    let transactions: [BudgetTransaction]
    
    // Derived
    var totalSpending: Decimal { returns - spending }
    var paymentsAndReturns: Decimal { payments + returnsApplied - transfersOut }
    var totalActivity: Decimal { fundedSpending - paymentsAndReturns }
}
