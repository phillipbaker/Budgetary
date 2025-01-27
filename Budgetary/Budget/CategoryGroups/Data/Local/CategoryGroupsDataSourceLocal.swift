//
//  CategoryGroupsDataSourceLocal.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//

public protocol CategoryGroupsDataSourceLocal {
    func categoryGroupsStream() async -> AsyncStream<[CategoryGroupPlain]>
    func findCategoryGroup(by id: String) -> CategoryGroupPlain
    func create(categoryGroup: CategoryGroupPlain)
    func update(categoryGroup: CategoryGroupPlain)
    func delete(categoryGroup: CategoryGroupPlain)
}
