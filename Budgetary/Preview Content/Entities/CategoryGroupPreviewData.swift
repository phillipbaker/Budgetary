//
//  CategoryGroupPreviewData.swift
//  Budgetary
//
//  Created by Phillip Baker on 01/11/2024.
//

import Foundation

extension CategoryGroup {
    static let inflow = CategoryGroup(
        id: UUID().uuidString,
        name: "Inflow",
        isHidden: false,
        assignedTotal: [:],
        activityTotal: [:],
        availableTotal: [:],
        categories: [.readyToAssign]
    )

    static let obligations = CategoryGroup(
        id: UUID().uuidString,
        name: "Immediate Obligations",
        isHidden: false,
        assignedTotal: [:],
        activityTotal: [:],
        availableTotal: [:],
        categories: [
            .rent,
            .councilTax,
            .utilities,
            .water,
            .internet,
            .tvLicense,
            .cellPhones
        ]
    )
    
    static let trueExpenses = CategoryGroup(
        id: UUID().uuidString,
        name: "True Expenses",
        isHidden: false,
        assignedTotal: [:],
        activityTotal: [:],
        availableTotal: [:],
        categories: [
            .ynab,
            .birthdays,
            .christmas,
            .lifeInsurance,
            .roadTax,
            .carInsurance,
            .homeInsurance,
            .carServiceRepairs
        ]
    )
    
    static let monthlyExpenses = CategoryGroup(
        id: UUID().uuidString,
        name: "Monthly Expenses",
        isHidden: false,
        assignedTotal: [:],
        activityTotal: [:],
        availableTotal: [:],
        categories: [
            .groceries,
            .commuting,
            .classesCamps,
            .petrolTolls,
            .homeSupplies,
            .homeImprovement,
            .kidsClothes,
            .gifts,
            .doctors,
            .amazonPrime,
            .prescriptions,
            .atmBankFees,
            .miscellaneous
        ]
    )
    
    static let fun = CategoryGroup(
        id: UUID().uuidString,
        name: "Fun",
        isHidden: false,
        assignedTotal: [:],
        activityTotal: [:],
        availableTotal: [:],
        categories: [
            .phil,
            .kids,
            .school,
            .streaming,
            .familyActivities,
            .takeout
        ]
    )
}
