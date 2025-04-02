//
//  BudgetPresentationPreviewData.swift
//  Budgetary
//
//  Created by Phillip Baker on 03/12/2024.
//

import Foundation

extension BudgetPresentation {
    static let mock = BudgetPresentation(
        id: UUID().uuidString,
        monthYear: .currentMonthYear,
        months: [.mock],
        filter: .allCategories,
        readyToAssign: [.aug2024: .mock],
        categoryGroups: [.obligations, .trueExpenses, .monthlyExpenses, .fun],
        start: .aug2024,
        end: .oct2024
    )
}

extension MonthPresentation {
    static let mock = MonthPresentation(
        id: UUID().uuidString,
        monthYear: .currentMonthYear,
        isDisabled: false,
        foregroundColor: .primary,
        backgroundColor: .secondary
    )
}

extension ReadyToAssignPresentation {
    static let mock = ReadyToAssignPresentation(
        readyToAssignFromLastMonth: "0.00",
        cashOverspendingFromLastMonth: "0.00",
        inflowThisMonth: "0.00",
        assignedThisMonth: "0.00",
        assignedInFuture: "0.00",
        readyToAssignThisMonth: "0.00",
        lightModeForegroundColor: .accentColor,
        darkModeForegroundColor: .accentColor,
        lightModeBackgroundColor: .secondary,
        darkModeBackgroundColor: .secondary,
        message: "Message.."
//        destination: .assignMoney
    )
}
