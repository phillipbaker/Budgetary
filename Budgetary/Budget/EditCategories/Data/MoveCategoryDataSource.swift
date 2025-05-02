//
//  Untitled.swift
//  Budgetary
//
//  Created by Phillip Baker on 29/04/2025.
//

import Factory

final class MoveCategoryDataSource: MoveCategorySource {
    let categoryGroupsDataSourceLocal: any CategoryGroupsDataSourceLocal = Container.shared.categoryGroupsDataSourceLocal()

    func findCategoryGroup(by id: String) async -> CategoryGroupPlain? {
        await categoryGroupsDataSourceLocal.findCategoryGroup(by: id)
    }
    
    func findCategoryGroup(containing categoryId: String) async -> CategoryGroupPlain? {
        await categoryGroupsDataSourceLocal.findCategoryGroup(containing: categoryId)
    }

    func update(categoryGroup: CategoryGroupPlain) async {
        await categoryGroupsDataSourceLocal.update(categoryGroup: categoryGroup)
    }
}
