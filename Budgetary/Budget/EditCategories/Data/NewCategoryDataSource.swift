//
//  NewCategoryDataSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 05/04/2025.
//

import Factory

class NewCategoryDataSource: NewCategorySource {    
    let categoryGroupsDataSourceLocal: any CategoryGroupsDataSourceLocal = Container.shared.categoryGroupsDataSourceLocal()
    
    func findCategoryGroup(by id: String) async -> CategoryGroupPlain? {
        await categoryGroupsDataSourceLocal.findCategoryGroup(by: id)
    }
    
    func update(categoryGroup: CategoryGroupPlain) async {
        await categoryGroupsDataSourceLocal.update(categoryGroup: categoryGroup)
    }
}
