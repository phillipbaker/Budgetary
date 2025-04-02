//
//  LoadCategoryGroupsUseCase.swift
//  Budgetary
//
//  Created by Phillip Baker on 02/11/2024.
//

import Factory

public final class LoadCategoryGroupsUseCase {
    let source: LoadCategoryGroupsSource = Container.shared.loadCategoryGroupsSource()
    let mapper: EditCategoriesMapper = Container.shared.editCategoriesMapper()
    
    func load() async -> [EditableCategoryGroup] {
        let categoryGroupsPlain = await source.allCategoryGroups()
        return mapper.map(categoryGroupsPlain: categoryGroupsPlain)
    }
}
