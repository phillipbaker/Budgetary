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
//            .countilTax,
            .utilities,
            .water,
            .internet,
//            .tvLicense,
//            .cellPhones
        ]
    )
    
    @MainActor static let trueExpenses = CategoryGroupDb(
        externalID: .init(),
        name: "True Expenses",
        isHidden: false,
        categories: [
            .ynab,
//            .birthdays,
//            .christmas,
//            .lifeInsurance,
//            .roadTax,
//            .carInsurance,
//            .homeInsurance,
//            .carServiceRepairs
        ]
    )
    
    @MainActor static let monthlyExpenses = CategoryGroupDb(
        externalID: .init(),
        name: "Monthly Expenses",
        isHidden: false,
        categories: [
            .groceries,
//            .commuting,
//            .classesCamps,
//            .petrolTolls,
//            .homeSupplies,
//            .homeImprovement,
//            .kidsClothes,
//            .gifts,
//            .doctors,
//            .amazonPrime,
//            .prescriptions,
//            .atmBankFees,
//            .miscellaneous
        ]
    )

    @MainActor static let fun = CategoryGroupDb(
        externalID: .init(),
        name: "Fun",
        isHidden: false,
        categories: [
            .phil,
//            .kids,
//            .school,
//            .streaming,
//            .familyActivities,
//            .takeout
        ]
    )
}
