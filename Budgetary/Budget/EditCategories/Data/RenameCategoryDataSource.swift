//
//  RenameCategoryDataSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 01/04/2025.
//

import Factory

final class RenameCategoryDataSource: RenameCategorySource {
    let categoryGroupsDataSourceLocal: any CategoryGroupsDataSourceLocal = Container.shared.categoryGroupsDataSourceLocal()

    func findCategoryGroup(containing categoryId: String) async -> CategoryGroupPlain? {
        await categoryGroupsDataSourceLocal.findCategoryGroup(containing: categoryId)
    }
    
    func update(categoryGroup: CategoryGroupPlain) async {
        await categoryGroupsDataSourceLocal.update(categoryGroup: categoryGroup)
    }
}
