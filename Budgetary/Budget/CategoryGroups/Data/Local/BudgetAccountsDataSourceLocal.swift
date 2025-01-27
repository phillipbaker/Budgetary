//
//  BudgetAccountsDataSourceLocal.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//

public protocol BudgetAccountsDataSourceLocal {
    func budgetAccountsStream() async -> AsyncStream<[BudgetAccountPlain]>
    func findBudgetAccount(by id: String) -> BudgetAccountPlain
    func create(budgetAccount: BudgetAccountPlain)
    func update(budgetAccount: BudgetAccountPlain)
    func delete(budgetAccount: BudgetAccountPlain)
}
