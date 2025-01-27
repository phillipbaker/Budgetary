//
//  AddCategorySource.swift
//  Budgetary
//
//  Created by Phillip Baker on 01/11/2024.
//

import Foundation

public protocol AddCategorySource {
    func findCategoryGroup(by id: String) -> CategoryGroup
    func add(_ category: Category, to group: CategoryGroup)
}

class AddCategorySourceData: AddCategorySource {
    func findCategoryGroup(by id: String) -> CategoryGroup {
        .fun
    }
    
    func add(_ category: Category, to group: CategoryGroup) {
    
    }
}
