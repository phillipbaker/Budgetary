//
//  CategoryGroupsDataSourceLocal.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//

import Foundation

public protocol CategoryGroupsDataSourceLocal: Sendable {
    associatedtype CategoryGroupBroadcaster: StreamBroadcaster<[CategoryGroupPlain]>
    nonisolated var broadcaster: CategoryGroupBroadcaster { get }

    func allCategoryGroups() async -> [CategoryGroupPlain]
    func findCategoryGroup(by id: String) async -> CategoryGroupPlain?
    func findCategoryGroup(containing categoryId: String) async -> CategoryGroupPlain?
    func addNew(categoryGroup: CategoryGroupPlain) async
    func update(categoryGroup: CategoryGroupPlain) async
    func update(categoryGroups: [CategoryGroupPlain]) async
    func delete(categoryGroup: CategoryGroupPlain) async
}
