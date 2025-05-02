//
//  NewCategorySource.swift
//  Budgetary
//
//  Created by Phillip Baker on 01/11/2024.
//

public protocol NewCategorySource {
    func findCategoryGroup(by id: String) async -> CategoryGroupPlain?
    func update(categoryGroup: CategoryGroupPlain) async
}
