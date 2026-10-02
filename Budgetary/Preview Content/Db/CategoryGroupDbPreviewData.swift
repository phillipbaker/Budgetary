//
//  CategoryGroupDbPreviewData.swift
//  Budgetary
//
//  Created by Phillip Baker on 18/11/2024.
//

extension Array where Element == CategoryGroupDb {
    @MainActor static let mock: [CategoryGroupDb] = [.obligations, .trueExpenses, .monthlyExpenses, .fun]
}

extension CategoryGroupDb {
    @MainActor static let obligations = CategoryGroupDb(
        externalID: .init(),
        name: "Immediate Obligations",
        isHidden: false,
        categories: [
            .rent,
            .utilities,
            .water,
            .internet
        ]
    )
    
    @MainActor static let trueExpenses = CategoryGroupDb(
        externalID: .init(),
        name: "True Expenses",
        isHidden: false,
        categories: [
            .ynab
        ]
    )
    
    @MainActor static let monthlyExpenses = CategoryGroupDb(
        externalID: .init(),
        name: "Monthly Expenses",
        isHidden: false,
        categories: [
            .groceries
        ]
    )

    @MainActor static let fun = CategoryGroupDb(
        externalID: .init(),
        name: "Fun",
        isHidden: false,
        categories: [
            .phil
        ]
    )
}
