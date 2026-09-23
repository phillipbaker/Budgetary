//
//  TransactionState.swift
//  Budgetary
//
//  Created by Phillip Baker on 27/01/2026.
//

public enum TransactionViewState {
    case notLoaded
    case loading
    case error(TransactionError)
    case loaded(TransactionPresentationState)
}
