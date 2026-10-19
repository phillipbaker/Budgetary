//
//  LoadBudgetAccountsSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 21/05/2025.
//

public protocol LoadBudgetAccountsSource: Sendable {
    func loadBudgetAccounts() async -> [BudgetAccountPlain]
    func loadCategoryGroups() async -> [CategoryGroupPlain]
    func loadPayees() async -> [PayeePlain]
}
