//
//  GetCategoryGroupsSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 10/05/2025.
//

public protocol GetCategoryGroupsSource: Sendable {
    func getCategoryGroups() async -> [CategoryGroupPlain]
}
