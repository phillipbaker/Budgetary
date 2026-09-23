//
//  CategoryGroupsDataSourceLocal.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//

public protocol CategoryGroupsDataSourceLocal: Sendable {
    func categoryGroups() async -> [CategoryGroupPlain]
    func findCategoryGroup(by id: ID<CategoryGroupPlain>) async -> CategoryGroupPlain?
    func findCategoryGroup(containing categoryID: ID<CategoryPlain>) async -> CategoryGroupPlain?
    func create(categoryGroup: CategoryGroupPlain) async
    func update(categoryGroup: CategoryGroupPlain) async
    func update(categoryGroups: [CategoryGroupPlain]) async
    func delete(categoryGroup: CategoryGroupPlain) async
}
