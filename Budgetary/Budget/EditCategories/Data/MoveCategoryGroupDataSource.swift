//
//  MoveCategoryGroupDataSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 29/04/2025.
//

import Factory

final class MoveCategoryGroupDataSource: MoveCategoryGroupSource {
    let categoryGroupsDataSourceLocal: any CategoryGroupsDataSourceLocal = Container.shared.categoryGroupsDataSourceLocal()

    func loadCategoryGroups() async -> [CategoryGroupPlain] {
        await categoryGroupsDataSourceLocal.loadCategoryGroups()
    }
    
    func update(categoryGroups: [CategoryGroupPlain]) async {
        await categoryGroupsDataSourceLocal.update(categoryGroups: categoryGroups)
    }
}
