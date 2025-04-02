//
//  RenameCategoryDataSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 01/04/2025.
//

import Factory

final class RenameCategoryDataSource: RenameCategorySource {
    let categoryGroupsDataSourceLocal: CategoryGroupsDataSourceLocal = Container.shared.categoryGroupsDataSourceLocal()
    
    func findCategory(by id: String) async -> CategoryPlain? {
        await categoryGroupsDataSourceLocal.findCategory(by: id)
    }
    
    func update(category: CategoryPlain) async {
        print("update categbory called in data source")
        await categoryGroupsDataSourceLocal.update(category: category)
    }
}
