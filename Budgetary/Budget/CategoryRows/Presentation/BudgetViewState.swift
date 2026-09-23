//
//  BudgetViewState.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/10/2024.
//

enum BudgetViewState {
    case notLoaded
    case loading
    case error(BudgetViewStateError)
    case budget(BudgetPresentationState)
}
