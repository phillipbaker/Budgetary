//
//  Budget.swift
//  Budgetary
//
//  Created by Phillip Baker on 14/08/2024.
//

import Foundation

public struct Budget: Equatable, Identifiable, Sendable {
    public let id: ID<Budget>
    let monthYear: MonthYear // TODO: - think I can/should remove this
    let filter: CategoryFilter // TODO: - think I can/should remove this
    let readyToAssign: [MonthYear: ReadyToAssign]
    let categoryGroups: [CategoryGroupRow]
    let creditCardPaymentGroup: CreditCardPaymentGroupRow
    let settings: BudgetSettings
    let start: MonthYear
    let end: MonthYear
}
