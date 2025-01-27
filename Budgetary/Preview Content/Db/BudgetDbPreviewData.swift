//
//  BudgetDbPreviewData.swift
//  Budgetary
//
//  Created by Phillip Baker on 28/11/2024.
//

import Foundation

extension BudgetDb: @unchecked Sendable {
    static let mock = BudgetDb(
        id: "UUID().uuidString",
        settings: BudgetSettingsDb(
            name: "UK Budget",
            curreny: "GBR",
            currencyFormet: "",
            numberFormat: "",
            dateFormat: ""
        ),
        budgetAccountIds: ["1", "2", "3"],
        categoryGroupIds: ["1", "2", "3", "4"]
    )
}
