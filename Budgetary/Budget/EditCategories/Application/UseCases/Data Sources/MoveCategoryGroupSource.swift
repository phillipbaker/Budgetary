//
//  ReorderGroupsSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/10/2024.
//

public protocol MoveCategoryGroupSource {
    func allCategoryGroups() async -> [CategoryGroupPlain]?
    func update(categoryGroups: [CategoryGroupPlain]) async
}
