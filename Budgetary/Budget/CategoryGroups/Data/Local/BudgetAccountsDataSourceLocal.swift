//
//  BudgetAccountsDataSourceLocal.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//

public protocol BudgetAccountsDataSourceLocal: Sendable {
    func budgetAccountsStream() async -> AsyncStream<[BudgetAccountPlain]>
    func findBudgetAccount(by id: String) async -> BudgetAccountPlain
    func create(budgetAccount: BudgetAccountPlain) async
    func update(budgetAccount: BudgetAccountPlain) async
    func delete(budgetAccount: BudgetAccountPlain) async
}
