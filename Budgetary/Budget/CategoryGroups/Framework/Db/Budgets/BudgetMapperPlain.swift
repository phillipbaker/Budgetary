//
//  BudgetMapperPlain.swift
//  Budgetary
//
//  Created by Phillip Baker on 03/11/2024.
//

import Foundation

final class BudgetMapperPlain {
    func mapDbToPlain(budgetDb: BudgetDb) -> BudgetPlain {
        return BudgetPlain(
            id: budgetDb.id,
            settings: mapDbToPlain(budgetSettingsDb: budgetDb.settings),
            budgetAccountIds: budgetDb.budgetAccountIds,
            categoryGroupIds: budgetDb.categoryGroupIds
        )
    }
    
    func mapDbToPlain(budgetSettingsDb: BudgetSettingsDb) -> BudgetSettingsPlain {
        return BudgetSettingsPlain(
            name: budgetSettingsDb.name,
            curreny: budgetSettingsDb.curreny,
            currencyFormet: budgetSettingsDb.currencyFormet,
            numberFormat: budgetSettingsDb.numberFormat,
            dateFormat: budgetSettingsDb.dateFormat
        )
    }
    
    func mapPlainToDb(budgetSettingsPlain: BudgetSettingsPlain) -> BudgetSettingsDb {
        return BudgetSettingsDb(
            name: budgetSettingsPlain.name,
            curreny: budgetSettingsPlain.curreny,
            currencyFormet: budgetSettingsPlain.currencyFormet,
            numberFormat: budgetSettingsPlain.numberFormat,
            dateFormat: budgetSettingsPlain.dateFormat
        )
    }
    
    func mapPlainToDb(budgetPlain: BudgetPlain) -> BudgetDb {
        return BudgetDb(
            id: budgetPlain.id,
            settings: mapPlainToDb(budgetSettingsPlain: budgetPlain.settings),
            budgetAccountIds: budgetPlain.budgetAccountIds,
            categoryGroupIds: budgetPlain.categoryGroupIds
        )
    }
}
