//
//  GetBudget.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//

import Dependencies

public class GetBudget {
    var source: GetBudgetSource
    var mapper: BudgetMapper
    
    public init(source: GetBudgetSource, mapper: BudgetMapper) {
        self.source = source
        self.mapper = mapper
    }
    
    func budget(for monthYear: MonthYear, filteredBy filterId: String) async -> AsyncStream<Budget> {
        let (budgetStream, continuation) = AsyncStream.makeStream(of: Budget.self)
        let filter = CategoryFilter(rawValue: filterId)
        for await data in await self.source.budgetData() {
            let budget = self.mapper.mapBudget(for: monthYear, filteredBy: filter ?? .allCategories, from: data)
            continuation.yield(budget)
            return budgetStream
        }
        continuation.finish()
        return budgetStream
    }
}
