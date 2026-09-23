//
//  MoveCategoryGroupDataSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 29/04/2025.
//

import Factory

final class MoveCategoryGroupDataSource: MoveCategoryGroupSource {
    let categoryGroupsDataSourceLocal: any CategoryGroupsDataSourceLocal = Container.shared.categoryGroupsDataSourceLocal()

    func allCategoryGroups() async -> [CategoryGroupPlain]? {
        await categoryGroupsDataSourceLocal.categoryGroups()
    }
    
    func update(categoryGroups: [CategoryGroupPlain]) async {
        await categoryGroupsDataSourceLocal.update(categoryGroups: categoryGroups)
    }
}
