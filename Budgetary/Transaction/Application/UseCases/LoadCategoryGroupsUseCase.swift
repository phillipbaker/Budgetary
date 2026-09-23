//
//  LoadCategoryGroupsUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 10/05/2025.
//

import Factory

final class LoadCategoryGroupsUseCase: Sendable {
    private let source: GetCategoryGroupsSource
    private let mapper: BudgetMapper
    
    init(
        source: GetCategoryGroupsSource = Container.shared.getCategoryGroupsSource(),
        mapper: BudgetMapper = Container.shared.budgetMapper()
    ) {
        self.source = source
        self.mapper = mapper
    }
    
    func execute() async -> [CategoryGroup] {
        let categoryGroups = await source.getCategoryGroups()
        return mapper.map(categoryGroupsPlain: categoryGroups)
    }
}
