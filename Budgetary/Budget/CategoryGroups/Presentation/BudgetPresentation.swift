//
//  BudgetPresentation.swift
//  Budgetary
//
//  Created by Phillip Baker on 25/10/2024.
//

import Foundation

public struct BudgetPresentation: Equatable, Identifiable, Sendable {
    public var id: String
    let monthYear: MonthYear
    let months: [MonthPresentation]
    let filter: CategoryFilterPresentation
    let readyToAssign: [MonthYear: ReadyToAssignPresentation]
    let categoryGroups: [CategoryGroupPresentation]
    let start: MonthYear
    let end: MonthYear
}
