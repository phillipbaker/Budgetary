//
//  TransactionCategoryPresentation.swift
//  Budgetary
//
//  Created by Phillip Baker on 22/11/2024.
//

public struct TransactionCategoryPresentation: Equatable, Hashable, Identifiable, Sendable {
    public let id: ID<TransactionCategoryPresentation>
    let name: String
}
