//
//  RemoveGroupSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/10/2024.
//

public protocol RemoveGroupSource {
    func findCategoryGroup(by id: ID<CategoryGroupPlain>) async -> CategoryGroupPlain?
    func remove(categoryGroup: CategoryGroupPlain) async
}
