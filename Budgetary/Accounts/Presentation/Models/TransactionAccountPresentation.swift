//
//  TransactionAccountPresentation.swift
//  Budgetary
//
//  Created by Phillip Baker on 22/05/2025.
//

public struct TransactionAccountPresentation: Equatable, Hashable, Identifiable, Sendable {
    public let id: ID<TransactionAccountPresentation>
    let name: String
}
