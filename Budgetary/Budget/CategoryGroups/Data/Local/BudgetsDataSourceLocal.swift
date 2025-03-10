//
//  BudgetDataSourceLocal.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//

public protocol BudgetDataSourceLocal: Sendable {
    func budgetStream() async -> AsyncStream<BudgetPlain>
    func findBudget(by id: String) async -> BudgetPlain
    func create(budget: BudgetPlain) async
    func update(budget: BudgetPlain) async
    func delete(budget: BudgetPlain) async
}
