//
//  BudgetDb.swift
//  Budgetary
//
//  Created by Phillip Baker on 03/11/2024.
//

import SwiftData

@Model
final class BudgetDb: Equatable {
    @Attribute(.unique) var id: String
    var settings: BudgetSettingsDb
    var budgetAccountIds: [String]
    var categoryGroupIds: [String]
    
    init(
        id: String,
        settings: BudgetSettingsDb,
        budgetAccountIds: [String],
        categoryGroupIds: [String]
    ) {
        self.id = id
        self.settings = settings
        self.budgetAccountIds = budgetAccountIds
        self.categoryGroupIds = categoryGroupIds
    }
}
