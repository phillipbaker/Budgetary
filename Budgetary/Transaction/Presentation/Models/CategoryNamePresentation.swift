//
//  CategoryName.swift
//  Budgetary
//
//  Created by Phillip Baker on 11/05/2025.
//

public struct CategoryNamePresentation: Equatable, Hashable, Identifiable, Sendable {
    public let id: ID<CategoryNamePresentation>
    let letter: String
    let categories: [TransactionCategoryPresentation]
}

public struct CategoryGroupNamePresentation: Equatable, Hashable, Identifiable, Sendable {
    public let id: ID<CategoryGroupNamePresentation>
    let name: String
}
