//
//  HideCategorySource.swift
//  Budgetary
//
//  Created by Phillip Baker on 28/04/2025.
//

public protocol HideCategorySource {
    func findCategoryGroup(containing categoryId: String) async -> CategoryGroupPlain?
    func update(categoryGroup: CategoryGroupPlain) async
}
