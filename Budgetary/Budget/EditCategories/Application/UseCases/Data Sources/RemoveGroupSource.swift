//
//  RemoveGroupSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/10/2024.
//

public protocol RemoveGroupSource {
    func findCategoryGroup(by id: String) -> CategoryGroup
    func remove(_ group: CategoryGroup)
}


class RemoveGroupSourceImpl: RemoveGroupSource {
    func findCategoryGroup(by id: String) -> CategoryGroup {
        .fun
    }
    
    func remove(_ group: CategoryGroup) {}
}

