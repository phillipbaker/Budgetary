//
//  AccountsState.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/05/2025.
//

public enum AccountsState: Sendable {
    case error
    case loading
    case success([BudgetAccountPresentation])
}
