//
//  CategoryName.swift
//  Budgetary
//
//  Created by Phillip Baker on 11/05/2025.
//

public struct CategoryName: Equatable, Hashable, Identifiable, Sendable {
    public let id: String
    let letter: String
    let groupId: String
    let groupName: String
    let categories: [TransactionCategoryPresentation]
}
