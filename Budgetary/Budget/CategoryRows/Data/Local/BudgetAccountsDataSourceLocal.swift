//
//  BudgetAccountsDataSourceLocal.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//

public protocol BudgetAccountsDataSourceLocal: Sendable {
    func loadBudgetAccounts() async -> [BudgetAccountPlain]
    func findBudgetAccount(by id: ID<BudgetAccountPlain>) async -> BudgetAccountPlain?
    func findBudgetAccount(containing id: ID<TransactionPlain>) async -> BudgetAccountPlain?
    func create(account: BudgetAccountPlain) async
    func update(account: BudgetAccountPlain) async
    func delete(account: BudgetAccountPlain) async
}
