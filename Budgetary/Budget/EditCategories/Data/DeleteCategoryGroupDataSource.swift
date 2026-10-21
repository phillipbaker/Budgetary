//
//  DeleteCategoryGroupDataSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 28/04/2025.
//

import Factory

final class DeleteCategoryGroupDataSource: DeleteCategoryGroupSource {
    let categoryGroupsDataSourceLocal: any CategoryGroupsDataSourceLocal = Container.shared.categoryGroupsDataSourceLocal()
    
    func findCategoryGroup(by id: ID<CategoryGroupPlain>) async -> CategoryGroupPlain? {
        await categoryGroupsDataSourceLocal.findCategoryGroup(by: id)
    }
    
    func delete(categoryGroup: CategoryGroupPlain) async {
        await categoryGroupsDataSourceLocal.delete(categoryGroup: categoryGroup)
    }
}
