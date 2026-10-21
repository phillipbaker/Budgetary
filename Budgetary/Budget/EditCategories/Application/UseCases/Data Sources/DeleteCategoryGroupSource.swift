//
//  DeleteCategoryGroupSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/10/2024.
//

public protocol DeleteCategoryGroupSource {
    func findCategoryGroup(by id: ID<CategoryGroupPlain>) async -> CategoryGroupPlain?
    func delete(categoryGroup: CategoryGroupPlain) async
}
