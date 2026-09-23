//
//  BudgetError.swift
//  Budgetary
//
//  Created by Phillip Baker on 19/01/2026.
//

public enum BudgetViewStateError: Error {
    case invalidAmountString
    case failedToMapViewState
    case unknownError
}

public enum BudgetError: Error {
    case dataError
    case assignMoneyFailed
    case invalidCategoryFilter
    case budgetLoadFailed
}

public enum TransactionError: Error {
    case failedToLoadTransaction
}
