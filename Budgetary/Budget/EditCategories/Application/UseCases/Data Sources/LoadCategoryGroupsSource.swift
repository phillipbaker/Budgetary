//
//  LoadCategoryGroupsSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 02/11/2024.
//

public protocol LoadCategoryGroupsSource: Sendable {
    func loadCategoryGroups() async -> [CategoryGroupPlain]
    func categoryGroupsStream() async -> AsyncStream<[CategoryGroupPlain]>
}
