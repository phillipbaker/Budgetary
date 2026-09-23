//
//  BudgetData.swift
//  Budgetary
//
//  Created by Phillip Baker on 19/01/2026.
//

public struct BudgetData: Equatable, Identifiable, Sendable {
    public let id: ID<BudgetData>
    var readyToAssign: [MonthYear: ReadyToAssign]
    var categoryGroups: [CategoryGroupRow]
    var creditCardPaymentGroup: CreditCardPaymentGroupRow
    var settings: BudgetSettings
    var start: MonthYear
    var end: MonthYear
}
