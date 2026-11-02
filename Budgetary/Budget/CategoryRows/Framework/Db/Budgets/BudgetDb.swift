//
//  BudgetDb.swift
//  Budgetary
//
//  Created by Phillip Baker on 03/11/2024.
//

import Foundation
import SwiftData

@Model
final class BudgetDb: Equatable {
    @Attribute(.unique) var externalID: UUID
    var settings: BudgetSettingsDb
    var budgetAccountIDs: [UUID]
    var categoryGroupIDs: [UUID]
    
    init(
        externalID: UUID,
        settings: BudgetSettingsDb,
        budgetAccountIDs: [UUID],
        categoryGroupIDs: [UUID]
    ) {
        self.externalID = externalID
        self.settings = settings
        self.budgetAccountIDs = budgetAccountIDs
        self.categoryGroupIDs = categoryGroupIDs
    }
}
