//
//  RemoveGroupDataSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 28/04/2025.
//

import Factory

final class RemoveGroupDataSource: RemoveGroupSource {
    let categoryGroupsDataSourceLocal: any CategoryGroupsDataSourceLocal = Container.shared.categoryGroupsDataSourceLocal()
    
    func findCategoryGroup(by id: String) async -> CategoryGroupPlain? {
        await categoryGroupsDataSourceLocal.findCategoryGroup(by: id)
    }
    
    func remove(categoryGroup: CategoryGroupPlain) async {
        await categoryGroupsDataSourceLocal.delete(categoryGroup: categoryGroup)
    }
}
