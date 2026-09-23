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
    var tabDestinations: [AppTab: [Destination]]
    var sheet: Sheet?
    var currencyCode: String
}

public enum Destination: Hashable, Sendable {
//     // Transaction
//    case payeePicker(PayeePresentation?)
//    case accountPicker(TransactionAccountPresentation?)
//    case categoryPicker(TransactionCategoryPresentation?)
}

public enum Sheet: String, Hashable, Identifiable, Sendable {
    public var id: String { rawValue }
    case transactionSheet
    case addAccountSheet
}
