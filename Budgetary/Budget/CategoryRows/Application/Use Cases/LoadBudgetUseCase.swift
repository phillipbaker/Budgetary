//
//  LoadBudgetUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 13/01/2026.
//

import Factory

struct LoadBudgetUseCase: Sendable {
    private let source: LoadBudgetSource
    private let mapper: BudgetRowMapper
    
    init(
        source: LoadBudgetSource = Container.shared.loadBudgetSource(),
        mapper: BudgetRowMapper = Container.shared.budgetRowMapper()
    ) {
        self.source = source
        self.mapper = mapper
    }
    
    func execute() async throws -> BudgetData {
        let budgetDataPlain = try await source.loadBudgetData()
        return mapper.mapBudgetData(from: budgetDataPlain)
    }
}
