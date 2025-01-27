//
//  CategoryGroupPresentation+Preview.swift
//  Budgetary
//
//  Created by Phillip Baker on 01/11/2024.
//

import Foundation

extension CategoryGroupPresentation: @unchecked Sendable {
    static let obligations = CategoryGroupPresentation(
        id: UUID().uuidString,
        name: "Immediate Obligations",
        isHidden: false,
        assignedTotal: [.currentMonthYear:"£90,090.62"],
        activityTotal: [.currentMonthYear:"£84,999.83"],
        availableTotal: [.currentMonthYear:"£98,898.98"],
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
    
    static let trueExpenses = CategoryGroupPresentation(
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
    
    static let monthlyExpenses = CategoryGroupPresentation(
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
    
    static let fun = CategoryGroupPresentation(
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
