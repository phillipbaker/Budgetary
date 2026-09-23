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
            id: ID<BudgetPlain>(budgetDb.externalID),
            settings: mapDbToPlain(budgetSettingsDb: budgetDb.settings),
            budgetAccountIDs: budgetDb.budgetAccountIDs.map { ID<BudgetAccountPlain>($0) },
            categoryGroupIDs: budgetDb.categoryGroupIDs.map { ID<CategoryGroupPlain>($0) }
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
            externalID: budgetPlain.id.rawValue,
            settings: mapPlainToDb(budgetSettingsPlain: budgetPlain.settings),
            budgetAccountIDs: budgetPlain.budgetAccountIDs.map { ID<BudgetAccountDb>($0) },
            categoryGroupIDs: budgetPlain.categoryGroupIDs.map { ID<CategoryGroupDb>($0) }
        )
    }
}
