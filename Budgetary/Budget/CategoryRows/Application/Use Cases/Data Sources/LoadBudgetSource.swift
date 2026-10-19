//
//  LoadBudgetSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 13/01/2026.
//

public protocol LoadBudgetSource: Sendable {
    func loadBudgetData() async throws -> BudgetDataPlain
}
