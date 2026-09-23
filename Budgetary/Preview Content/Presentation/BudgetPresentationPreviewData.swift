//
//  BudgetPresentationPreviewData.swift
//  Budgetary
//
//  Created by Phillip Baker on 03/12/2024.
//

import Foundation

extension BudgetPresentation {
    static let mock = BudgetPresentation(
        id: .init(),
        monthYear: .currentMonthYear,
        months: [.mock],
        readyToAssign: .mock,
        categoryGroups: [.obligations, .trueExpenses, .monthlyExpenses, .fun],
        creditCardPaymentGroup: CreditCardPaymentGroupPresentation(
            id: .init(),
            name: "Credit Card Payments Mock",
            isHidden: false,
            assignedTotal: [:],
            activityTotal: [:],
            availableTotal: [:],
            categories: []
        )
    )
}

extension MonthPresentation {
    static let mock = MonthPresentation(
        id: .init(),
        monthYear: .currentMonthYear,
        isDisabled: false,
        isCurrentMonth: true,
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
