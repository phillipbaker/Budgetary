//
//  AddAccountViewState.swift
//  Budgetary
//
//  Created by Phillip Baker on 29/01/2026.
//

enum AddAccountViewState {
    case notLoaded
    case loading
    case error(AccountsViewStateError)
    case loaded
}
