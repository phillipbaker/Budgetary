//
//  TransactionState.swift
//  Budgetary
//
//  Created by Phillip Baker on 27/01/2026.
//

enum TransactionState: Sendable {
    case notLoaded
    case loading
    case error(TransactionError)
    case loaded(TransactionStateData)
}

extension TransactionState {
    mutating func withLoaded(_ update: (inout TransactionStateData) -> Void) {
        guard case var .loaded(data) = self else { return }
        update(&data)
        self = .loaded(data)
    }

    var data: TransactionStateData? {
        guard case let .loaded(data) = self else { return nil }
        return data
    }
}
