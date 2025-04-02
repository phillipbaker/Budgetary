//
//  LoadCategoryGroupsSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 02/11/2024.
//

import Factory

public protocol LoadCategoryGroupsSource {
    func allCategoryGroups() async -> [CategoryGroupPlain]
}

final class LoadCategoryGroupsDataSource: LoadCategoryGroupsSource {
    let categoryGroupsDataSourceLocal: CategoryGroupsDataSourceLocal = Container.shared.categoryGroupsDataSourceLocal()
    
    func allCategoryGroups() async -> [CategoryGroupPlain] {
        await categoryGroupsDataSourceLocal.allCategoryGroups()
    }
}
