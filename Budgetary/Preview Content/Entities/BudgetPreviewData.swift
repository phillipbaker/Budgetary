//
//  BudgetPreviewData.swift
//  Budgetary
//
//  Created by Phillip Baker on 25/08/2024.
//

import Foundation

extension Budget {
    static let preview = Budget(
        id: .init(),
        monthYear: .currentMonthYear,
        filter: .allCategories,
        readyToAssign: [.currentMonthYear: .mock],
        categoryGroups: [.obligations, .trueExpenses, .monthlyExpenses, .fun],
        creditCardPaymentGroup: .creditCards,
        settings: BudgetSettings(
            name: "UK Budget",
            curreny: "GBP",
            currencyFormet: "",
            numberFormat: "",
            dateFormat: ""
        ),
        start: .sep2024,
        end: .oct2024
    )
}

extension ReadyToAssign {
    static let mock = ReadyToAssign(
        availableToAssignFromLastMonth: 100.00,
        inflowThisMonth: 1000.00,
        totalInflowsThisMonth: 1100.00,
        cashOverspendingLastMonth: 0.00,
        assignedThisMonth: 900.00,
        assignedInFuture: 0.00,
        totalOutflowsThisMonth: 900.00,
        readyToAssignThisMonth: 100.00
    )
}
