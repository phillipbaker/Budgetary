//
//  CategoryGroupDb+Mock.swift
//  Budgetary
//
//  Created by Phillip Baker on 18/11/2024.
//

// MARK: - All

extension [CategoryGroupDb] {
    static var mock: [CategoryGroupDb] {
        [.obligations, .trueExpenses, .monthlyExpenses, .fun]
    }
}

// MARK: - Fixtures

extension CategoryGroupDb {
    static var obligations: CategoryGroupDb {
        CategoryGroupDb(
            externalID: .mock(.obligations),
            name: "Immediate Obligations",
            isHidden: false,
            categories: [
                .rent,
                .councilTax,
                .water,
                .utilities,
                .internet,
                .tvLicense,
                .cellPhones
            ]
        )
    }
    
    static var trueExpenses: CategoryGroupDb {
        CategoryGroupDb(
            externalID: .mock(.trueExpenses),
            name: "True Expenses",
            isHidden: false,
            categories: [
                .christmas,
                .birthdays,
                .homeInsurance,
                .carInsurance,
                .carServiceRepairs,
                .roadTax,
                .lifeInsurance
            ]
        )
    }
    
    static var monthlyExpenses: CategoryGroupDb {
        CategoryGroupDb(
            externalID: .mock(.monthlyExpenses),
            name: "Monthly Expenses",
            isHidden: false,
            categories: [
                .groceries,
                .kidsClothes,
                .classesCamps,
                .commuting,
                .homeImprovement,
                .homeSupplies,
                .petrolTolls,
                .school,
                .atmBankFees,
                .prescriptions,
                .amazonPrime,
                .doctors,
                .gifts,
                .miscellaneous
            ]
        )
    }

    static var fun: CategoryGroupDb {
        CategoryGroupDb(
            externalID: .mock(.fun),
            name: "Fun",
            isHidden: false,
            categories: [
                .streaming,
                .familyActivities,
                .takeout,
                .phil,
                .kids
            ]
        )
    }
}
