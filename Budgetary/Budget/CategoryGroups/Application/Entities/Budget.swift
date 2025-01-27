//
//  Budget.swift
//  Budgetary
//
//  Created by Phillip Baker on 14/08/2024.
//

import Foundation

public struct Budget: Equatable, Identifiable, Sendable {
    public let id: String
    let monthYear: MonthYear
    let filter: CategoryFilter
    let readyToAssign: [MonthYear: ReadyToAssign]
    let categoryGroups: [CategoryGroup]
    let settings: BudgetSettings
    let start: MonthYear
    let end: MonthYear
    
//    var debtAccounts: [DebtAccount]
//    var trackingAccounts: [TrackingAccount]
//    var flags
//    var displayOptions
}
