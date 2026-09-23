//
//  NewCategorySource.swift
//  Budgetary
//
//  Created by Phillip Baker on 01/11/2024.
//

public protocol NewCategorySource: Sendable {
    func findCategoryGroup(by id: ID<CategoryGroupPlain>) async -> CategoryGroupPlain?
    func update(categoryGroup: CategoryGroupPlain) async
}
