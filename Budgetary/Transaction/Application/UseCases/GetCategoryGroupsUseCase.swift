//
//  GetCategortGroupsUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 10/05/2025.
//

import Factory

final class GetCategoryGroupsUseCase {
    let source: GetCategoryGroupsSource = Container.shared.getCategoryGroupsSource()
    let mapper: BudgetMapper = Container.shared.budgetMapper()
    
    func getCategoryGroups() async -> [CategoryGroupEntity] {
        let categoryGroups = await source.getCategoryGroups()
        return mapper.map(categoryGroupsPlain: categoryGroups)
    }
}
