//
//  BudgetDataSourceLocal.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//

public protocol BudgetDataSourceLocal {
    func budgetStream() async -> AsyncStream<BudgetPlain>
    func findBudget(by id: String) -> BudgetPlain
    func create(budget: BudgetPlain)
    func update(budget: BudgetPlain)
    func delete(budget: BudgetPlain)
}
