//
//  LoadCategoryGroupsSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 10/05/2025.
//

public protocol LoadCategoryGroupsSource: Sendable {
    func loadCategoryGroups() async -> [CategoryGroupPlain]
}
