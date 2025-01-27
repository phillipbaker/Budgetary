//
//  ReorderCategoriesSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/10/2024.
//

import Foundation

public protocol ReorderCategoriesSource {
    func findCategoryGroup(by id: String) -> CategoryGroup
    func moveCategories(in group: CategoryGroup, from offsets: IndexSet, to destination: Int)
}

class ReorderCategoriesSourceImpl: ReorderCategoriesSource {
    func findCategoryGroup(by id: String) -> CategoryGroup {
        .fun
    }
    
    func moveCategories(in group: CategoryGroup, from offsets: IndexSet, to destination: Int) {
        
    }
}
