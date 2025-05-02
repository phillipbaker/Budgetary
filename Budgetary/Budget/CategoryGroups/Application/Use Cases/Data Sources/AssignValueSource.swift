//
//  AssignValueSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 14/02/2025.
//

public protocol AssignMoneySource {
    func findCategoryGroup(containing categoryId: String) async -> CategoryGroupPlain?
    func update(categoryGroup: CategoryGroupPlain) async
}
