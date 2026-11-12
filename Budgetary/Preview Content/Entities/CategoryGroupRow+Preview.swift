//
//  CategoryGroupRow+Preview.swift
//  Budgetary
//
//  Created by Phillip Baker on 01/11/2024.
//

import Foundation

extension CategoryGroupRow {
    static let inflow = CategoryGroupRow(
        id: .init(),
        name: "Inflow",
        kind: .inflow,
        isHidden: false,
        assignedTotal: [:],
        activityTotal: [:],
        availableTotal: [:],
        categories: [.readyToAssign]
    )

    static let obligations = CategoryGroupRow(
        id: .init(),
        name: "Immediate Obligations",
        kind: .regular,
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
    
    static let trueExpenses = CategoryGroupRow(
        id: .init(),
        name: "True Expenses",
        kind: .regular,
        isHidden: false,
        assignedTotal: [:],
        activityTotal: [:],
        availableTotal: [:],
        categories: [
            .birthdays,
            .christmas,
            .lifeInsurance,
            .roadTax,
            .carInsurance,
            .homeInsurance,
            .carServiceRepairs
        ]
    )
    
    static let monthlyExpenses = CategoryGroupRow(
        id: .init(),
        name: "Monthly Expenses",
        kind: .regular,
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
    
    static let fun = CategoryGroupRow(
        id: .init(),
        name: "Fun",
        kind: .regular,
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
