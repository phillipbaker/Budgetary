//
//  RemoveCategorySource.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/10/2024.
//

import Foundation

public protocol RemoveCategorySource {
    func findCategoryGroup(by id: String) -> CategoryGroup
    func removeCategory(id: String, from group: CategoryGroup)
}

class RemoveCategorySourceImpl: RemoveCategorySource {
    
    func findCategoryGroup(by id: String) -> CategoryGroup {
        .fun
    }
    
    func removeCategory(id: String, from group: CategoryGroup) {
        
    }

}
