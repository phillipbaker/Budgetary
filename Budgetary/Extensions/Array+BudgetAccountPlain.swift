//
//  Array+BudgetAccountPlain.swift
//  Budgetary
//
//  Created by Phillip Baker on 05/12/2025.
//

extension Array where Element == BudgetAccountPlain {
    var transactions: [TransactionPlain] {
        return self.flatMap { $0.transactions }
    }
}
