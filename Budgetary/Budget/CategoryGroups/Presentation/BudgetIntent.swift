//
//  BudgetIntent.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/10/2024.
//

public enum BudgetIntent: Sendable {
    case getBudget(monthYear: MonthYear, filterId: String)
    case budgetSwipedLeftGesture(monthYear: MonthYear, filterId: String)
    case budgetSwipedRightGesture(monthYear: MonthYear, filterId: String)
    case filterButtonTapped(monthYear: MonthYear, filterId: String)
    case monthPickerMonthSelected(monthYear: MonthYear, filterId: String)
    case clearFilterButtonTapped(monthYear: MonthYear)
    case updateAssignedAmount(categoryId: String, monthYear: MonthYear, amount: String)
}
