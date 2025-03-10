//
//  AssignMoneyDataSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 15/02/2025.
//

import Foundation

public class AssignMoneyDataSource: AssignValueSource {
    let categoryGroupsDataSourceLocal: CategoryGroupsDataSourceLocal
    
    init(categoryGroupsDataSourceLocal: CategoryGroupsDataSourceLocal) {
        self.categoryGroupsDataSourceLocal = categoryGroupsDataSourceLocal
    }
    
    public func findCategory(by id: String) async -> CategoryPlain? {
        await categoryGroupsDataSourceLocal.findCategory(by: id)
    }
    
    public func update(category: CategoryPlain) async {
        await categoryGroupsDataSourceLocal.update(category: category)
    }
}
