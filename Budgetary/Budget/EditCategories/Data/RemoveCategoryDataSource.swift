//
//  RemoveCategoryDataSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 28/04/2025.
//

import Factory

final class RemoveCategoryDataSource: RemoveCategorySource {
    let categoryGroupsDataSourceLocal: any CategoryGroupsDataSourceLocal = Container.shared.categoryGroupsDataSourceLocal()
    
    func findCategoryGroup(containing categoryID: ID<CategoryPlain>) async -> CategoryGroupPlain? {
        await categoryGroupsDataSourceLocal.findCategoryGroup(containing: categoryID)
    }
    
    func update(categoryGroup: CategoryGroupPlain) async {
        await categoryGroupsDataSourceLocal.update(categoryGroup: categoryGroup)
    }
}
