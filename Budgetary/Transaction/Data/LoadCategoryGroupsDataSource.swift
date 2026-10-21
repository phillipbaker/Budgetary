//
//  LoadCategoryGroupsDataSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 10/05/2025.
//

import Factory

final class LoadCategoryGroupsDataSource: LoadCategoryGroupsSource {
    let categoryGroupsDataSourceLocal: any CategoryGroupsDataSourceLocal = Container.shared.categoryGroupsDataSourceLocal()
    
    func loadCategoryGroups() async -> [CategoryGroupPlain] {
        return await categoryGroupsDataSourceLocal.loadCategoryGroups()
    }
}
