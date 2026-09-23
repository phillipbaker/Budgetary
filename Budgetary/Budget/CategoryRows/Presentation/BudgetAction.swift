//
//  BudgetAction.swift
//  Budgetary
//
//  Created by Phillip Baker on 31/10/2024.
//

import Foundation

public enum BudgetAction: Sendable {
    case budgetTabAppeared
    case filterButtonTapped(filterID: String)
    case clearFilterButtonTapped(filterID: String)
    case budgetSwipedLeftGesture(monthYear: MonthYear)
    case budgetSwipedRightGesture(monthYear: MonthYear)
    case monthPickerMonthSelected(monthYear: MonthYear)
    case updateAssignedAmount(assignedAmount: Decimal, categoryID: BudgetRowID, monthYear: MonthYear)
}
