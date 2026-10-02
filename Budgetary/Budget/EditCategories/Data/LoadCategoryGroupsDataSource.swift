//
//  LoadCategoryGroupsDataSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 03/04/2025.
//

import Factory

final class LoadCategoryGroupsDataSource: LoadCategoryGroupsSource {
    let categoryGroupsDataSourceLocal: any CategoryGroupsDataSourceLocal
    
    init(categoryGroupsDataSourceLocal: any CategoryGroupsDataSourceLocal = Container.shared.categoryGroupsDataSourceLocal()) {
        self.categoryGroupsDataSourceLocal = categoryGroupsDataSourceLocal
    }
    
    let (categoryGroupsStream, continuation) = AsyncStream.makeStream(of: [CategoryGroupPlain].self, bufferingPolicy: .bufferingNewest(1))
    
    let id = "LoadCategoryGroupsDataSource"
    
    func loadCategoryGroups() async -> [CategoryGroupPlain] {
        await categoryGroupsDataSourceLocal.categoryGroups()
    }

    func categoryGroupsStream() async -> AsyncStream<[CategoryGroupPlain]> {
        return categoryGroupsStream
    }
}
