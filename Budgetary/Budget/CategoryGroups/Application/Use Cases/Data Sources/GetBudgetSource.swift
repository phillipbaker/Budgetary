//
//  GetBudgetSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//

public protocol GetBudgetSource: Sendable {
    func budgetData() async -> AsyncStream<CombinedBudgetData>
}
