//
//  BudgetPlain.swift
//  Budgetary
//
//  Created by Phillip Baker on 03/11/2024.
//

import Foundation

public struct BudgetPlain: Equatable, Sendable {
    let id: String
    let settings: BudgetSettingsPlain
    let budgetAccountIds: [String]
    let categoryGroupIds: [String]
}
