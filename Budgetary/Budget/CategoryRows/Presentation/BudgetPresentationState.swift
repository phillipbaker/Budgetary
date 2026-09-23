//
//  BudgetPresentationState.swift
//  Budgetary
//
//  Created by Phillip Baker on 19/01/2026.
//

struct BudgetPresentationState {
    let budget: BudgetPresentation
    let monthYear: MonthYear
    let filter: CategoryFilterPresentation
    let swipeLeftGesture: () -> Void
    let swipeRightGesture: () -> Void
}
