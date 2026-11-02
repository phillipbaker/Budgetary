//
//  BudgetAccountDb+Mock.swift
//  Budgetary
//
//  Created by Phillip Baker on 28/11/2024.
//

import Foundation

// MARK: - All

extension [BudgetAccountDb] {
    static var mock: [BudgetAccountDb] {
        [.hsbcChecking, .barclays, .hsbcSavings, .capitalOneCard]
    }
}

// MARK: - Fixtures

extension BudgetAccountDb {
    static var hsbcChecking: BudgetAccountDb {
        BudgetAccountDb(
            externalID: .mock(.hsbcChecking),
            name: "HSBC Checking",
            accountType: .checking,
            startingBalance: 0.0,
            notes: "Notes go here...",
            isClosed: false,
            transactions: [
                .sepInflow,
                .octInflow,
                .octAA,
                .novInflow,
                .novRent,
                .decInflow
            ]
        )
    }
    
    static var barclays: BudgetAccountDb {
        BudgetAccountDb(
            externalID: .mock(.barclays),
            name: "Barclays",
            accountType: .checking,
            startingBalance: 0.00,
            notes: "Notes",
            isClosed: false,
            transactions: []
        )
    }

    static var hsbcSavings: BudgetAccountDb {
        BudgetAccountDb(
            externalID: .mock(.hsbcSavings),
            name: "HSBC Savings",
            accountType: .savings,
            startingBalance: 0.00,
            notes: "Notes",
            isClosed: false,
            transactions: []
        )
    }
    
    static var capitalOneCard: BudgetAccountDb {
        BudgetAccountDb(
            externalID: .mock(.capitalOneCard),
            name: "Capital One Card",
            accountType: .creditCard,
            startingBalance: 0.00,
            notes: "",
            isClosed: false,
            transactions: []
        )
    }
}
