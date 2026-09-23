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
    
    func execute() async -> BudgetData {
        let combinedBudgetData = await source.budgetData()
        return mapper.mapBudgetData(from: combinedBudgetData)
    }
}
