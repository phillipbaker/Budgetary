//
//  AssignMoneyDataSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 15/02/2025.
//

import Factory
import Foundation

public final class AssignMoneyDataSource: AssignMoneySource {
    let categoryGroupsDataSourceLocal: any CategoryGroupsDataSourceLocal = Container.shared.categoryGroupsDataSourceLocal()
    
    public func findCategoryGroup(containing categoryId: String) async -> CategoryGroupPlain? {
        await categoryGroupsDataSourceLocal.findCategoryGroup(containing: categoryId)
    }
    
    public func update(categoryGroup: CategoryGroupPlain) async {
        await categoryGroupsDataSourceLocal.update(categoryGroup: categoryGroup)
    }
}
