//
//  HideCategoryGroupSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 28/04/2025.
//

public protocol HideCategoryGroupSource {
    func findCategoryGroup(by id: ID<CategoryGroupPlain>) async -> CategoryGroupPlain?
    func update(categoryGroup: CategoryGroupPlain) async
}
