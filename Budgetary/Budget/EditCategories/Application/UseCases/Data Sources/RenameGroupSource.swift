//
//  RenameGroupSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/10/2024.
//

public protocol RenameGroupSource {
    func findCategoryGroup(by id: ID<CategoryGroupPlain>) async -> CategoryGroupPlain?
    func update(categoryGroup: CategoryGroupPlain) async
}
