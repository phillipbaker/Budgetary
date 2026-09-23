//
//  GetCategoryGroupsDataSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 10/05/2025.
//

import Factory

final class GetCategoryGroupsDataSource: GetCategoryGroupsSource {
    let categoryGroupsDataSourceLocal: any CategoryGroupsDataSourceLocal = Container.shared.categoryGroupsDataSourceLocal()
    
    func getCategoryGroups() async -> [CategoryGroupPlain] {
        return await categoryGroupsDataSourceLocal.categoryGroups()
    }
}
