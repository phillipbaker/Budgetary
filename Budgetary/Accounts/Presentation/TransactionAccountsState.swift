//
//  TransactionAccountsState.swift
//  Budgetary
//
//  Created by Phillip Baker on 25/05/2025.
//

public enum TransactionAccountsState: Sendable {
    case error
    case loading
    case success([TransactionAccountPresentation])
}
