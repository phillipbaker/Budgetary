//
//  AccountsViewState.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/05/2025.
//

public enum AccountsViewState: Sendable {
    case notLoaded
    case error(AccountsViewStateError)
    case loading
    case loaded(AccountsPresentationState)
}

