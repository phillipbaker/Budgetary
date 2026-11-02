//
//  BudgetDb+Mock.swift
//  Budgetary
//
//  Created by Phillip Baker on 28/11/2024.
//

import Foundation

extension BudgetDb {
    static var mock: BudgetDb {
        BudgetDb(
            externalID: .mock(.ukBudget),
            settings: BudgetSettingsDb(
                name: "UK Budget",
                curreny: "GBP",
                currencyFormet: "",
                numberFormat: "",
                dateFormat: ""
            ),
            budgetAccountIDs: [BudgetAccountDb].mock.map(\.externalID),
            categoryGroupIDs: [CategoryGroupDb].mock.map(\.externalID)
        )
    }
}
