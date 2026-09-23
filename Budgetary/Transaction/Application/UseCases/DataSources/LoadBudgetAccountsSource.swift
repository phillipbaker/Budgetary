//
//  LoadBudgetAccountsSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 21/05/2025.
//

public protocol LoadBudgetAccountsSource: Sendable {
    func accounts() async -> [BudgetAccountPlain]
    func categoryGroups() async -> [CategoryGroupPlain]
    func payees() async -> [PayeePlain]
}
