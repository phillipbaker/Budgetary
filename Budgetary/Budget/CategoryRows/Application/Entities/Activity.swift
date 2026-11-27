//
//  Activity.swift
//  Budgetary
//
//  Created by Phillip Baker on 19/11/2024.
//

import Foundation

public struct Activity: Equatable, Hashable, Sendable {
    // Stored
    let cashTotal: Decimal
    let creditTotal: Decimal
    let transactions: [BudgetTransaction]
    
    // Derived
    var total: Decimal { cashTotal + creditTotal }
    
    init(transactions: [BudgetTransaction], creditCardAccountIDs: Set<ID<TransactionAccount>>) {
        let isOnCreditCard: (BudgetTransaction) -> Bool = { creditCardAccountIDs.contains($0.account.id) }
        self.transactions = transactions
        self.creditTotal = transactions.filter(isOnCreditCard).netAmount
        self.cashTotal = transactions.filter { !isOnCreditCard($0) }.netAmount
    }
}

