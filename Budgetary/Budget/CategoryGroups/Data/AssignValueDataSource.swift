//
//  AssignMoneyDataSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 15/02/2025.
//

import Factory
import Foundation

public final class AssignMoneyDataSource: AssignMoneySource {
    let categoryGroupsDataSourceLocal: CategoryGroupsDataSourceLocal = Container.shared.categoryGroupsDataSourceLocal()
    
    public func findCategory(by id: String) async -> CategoryPlain? {
        await categoryGroupsDataSourceLocal.findCategory(by: id)
    }
    
    public func update(category: CategoryPlain) async {
        await categoryGroupsDataSourceLocal.update(category: category)
    }
}
