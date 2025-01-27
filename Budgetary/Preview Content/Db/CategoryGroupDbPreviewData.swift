//
//  CategoryGroupDbPreviewData.swift
//  Budgetary
//
//  Created by Phillip Baker on 18/11/2024.
//

extension Array where Element == CategoryGroupDb {
    static let mock: [CategoryGroupDb] = [.obligations, .trueExpenses, .monthlyExpenses, .fun]
}

extension CategoryGroupDb: @unchecked Sendable {
    static let obligations = CategoryGroupDb(
        id: "1",
        name: "Immediate Obligations",
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
    
    static let trueExpenses = CategoryGroupDb(
        id: "2",
        name: "True Expenses",
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
    
    static let monthlyExpenses = CategoryGroupDb(
        id: "3",
        name: "Monthly Expenses",
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

    static let fun = CategoryGroupDb(
        id: "4",
        name: "Fun",
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
