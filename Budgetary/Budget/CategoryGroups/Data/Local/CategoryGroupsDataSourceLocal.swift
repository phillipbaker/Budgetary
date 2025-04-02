//
//  CategoryGroupsDataSourceLocal.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//

public protocol CategoryGroupsDataSourceLocal: Sendable {
    func categoryGroupsStream() async -> AsyncStream<[CategoryGroupPlain]>
    func allCategoryGroups() async -> [CategoryGroupPlain]
    func findCategoryGroup(by id: String) async -> CategoryGroupPlain
    func findCategory(by id: String) async -> CategoryPlain
    func create(categoryGroup: CategoryGroupPlain) async
    func update(categoryGroup: CategoryGroupPlain) async
    func update(category: CategoryPlain) async
    func delete(categoryGroup: CategoryGroupPlain) async
}
