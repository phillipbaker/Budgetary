//
//  TransactionAccount.swift
//  Budgetary
//
//  Created by Phillip Baker on 22/05/2025.
//

public struct TransactionAccount: Equatable, Hashable, Identifiable, Sendable {
    public let id: ID<TransactionAccount>
    let name: String
}
