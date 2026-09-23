//
//  LoadTransactionAccountsSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 05/02/2026.
//

public protocol LoadTransactionAccountsSource: Sendable {
    func accounts() async -> [BudgetAccountPlain]
}
