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
            externalID: .init(),
            settings: BudgetSettingsDb(
                name: "UK Budget",
                curreny: "GBR",
                currencyFormet: "",
                numberFormat: "",
                dateFormat: ""
            ),
            budgetAccountIDs: [.init(), .init(), .init()],
            categoryGroupIDs: [.init(), .init(), .init()]
        )
    }
}
