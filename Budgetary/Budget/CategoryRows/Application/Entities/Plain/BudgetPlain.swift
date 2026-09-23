//
//  BudgetPlain.swift
//  Budgetary
//
//  Created by Phillip Baker on 03/11/2024.
//

import Foundation

public struct BudgetPlain: Equatable, Sendable {
    let id: ID<BudgetPlain>
    let settings: BudgetSettingsPlain
    let budgetAccountIDs: [ID<BudgetAccountPlain>]
    let categoryGroupIDs: [ID<CategoryGroupPlain>]
}
