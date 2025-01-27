//
//  GetBudgetSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//

import Dependencies

public protocol GetBudgetSource {
    func budgetData() async -> AsyncStream<CombinedBudgetData>
}
