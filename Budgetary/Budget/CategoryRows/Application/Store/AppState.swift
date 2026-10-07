//
//  AppState.swift
//  Budgetary
//
//  Created by Phillip Baker on 19/01/2026.
//

struct AppState: Sendable {
    var homeState: HomeState
    var payeesState: PayeesState
    var budgetState: BudgetState
    var accountsState: AccountsState
    var transactionState: TransactionState
    var monthYear: MonthYear
    var filter: CategoryFilter
    var sheet: Sheet?
    var currencyCode: String
}

public enum Sheet: String, Hashable, Identifiable, Sendable {
    public var id: String { rawValue }
    case transactionSheet
    case addAccountSheet
}
