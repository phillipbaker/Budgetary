//
//  RemoveCategorySource.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/10/2024.
//

public protocol RemoveCategorySource {
    func findCategoryGroup(containing categoryId: String) async -> CategoryGroupPlain?
    func update(categoryGroup: CategoryGroupPlain) async
}
