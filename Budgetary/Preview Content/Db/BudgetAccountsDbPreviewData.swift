//
//  BudgetAccountsDbPreviewData.swift
//  Budgetary
//
//  Created by Phillip Baker on 28/11/2024.
//

import Foundation

extension UUID {
    static let hsbcChecking: Self = .init(uuidString: "00000000-0000-0000-0000-000000000001")!
    static let barclays: Self = .init(uuidString: "00000000-0000-0000-0000-000000000002")!
    static let hsbcSavings: Self = .init(uuidString: "00000000-0000-0000-0000-000000000003")!
    static let capitalOneCard: Self = .init(uuidString: "00000000-0000-0000-0000-000000000004")!
}

extension Array where Element == BudgetAccountDb {
    nonisolated(unsafe) static let mock = [BudgetAccountDb.hsbcChecking, .barclays, .hsbcSavings, .capitalOneCard]
}

extension BudgetAccountDb {
    nonisolated(unsafe) static let hsbcChecking = BudgetAccountDb(
        externalID: .hsbcChecking,
        name: "HSBC Checking",
        accountType: .checking,
        startingBalance: 0.0,
        notes: "Notes go here...",
        isClosed: false,
        transactions: [
            TransactionDb(
                externalID: .init(),
                date: .sepEigth2024,
                memo: "",
                amount: .inflow(100),
                isCleared: true,
                payeeID: .init(),
                categoryID: .init()
            ),
            TransactionDb(
                externalID: .init(),
                date: .octEigth2024,
                memo: "",
                amount: .inflow(100),
                isCleared: true,
                payeeID: .init(),
                categoryID: .init()
            ),
            TransactionDb(
                externalID: .init(),
                date: .novEigth2024,
                memo: "",
                amount: .inflow(1000),
                isCleared: true,
                payeeID: .init(),
                categoryID: .init()
            ),
            TransactionDb(
                externalID: .init(),
                date: .decEigth2024,
                memo: "",
                amount: .inflow(100),
                isCleared: true,
                payeeID: .init(),
                categoryID: .init()
            ),
            TransactionDb(
                externalID: .init(),
                date: .octEigth2024,
                memo: "",
                amount: .outflow(40),
                isCleared: true,
                payeeID: .init(),
                categoryID: .init()
            ),
            TransactionDb(
                externalID: .init(),
                date: .novEigth2024,
                memo: "Memo goes here...",
                amount: .outflow(500),
                isCleared: true,
                payeeID: .init(),
                categoryID: .init()
            )
        ]
    )
    
    nonisolated(unsafe) static let barclays = BudgetAccountDb(
        externalID: .barclays,
        name: "Barclays",
        accountType: .checking,
        startingBalance: 0.00,
        notes: "Notes",
        isClosed: false,
        transactions: []
    )

    nonisolated(unsafe) static let hsbcSavings = BudgetAccountDb(
        externalID: .hsbcSavings,
        name: "HSBC Savings",
        accountType: .savings,
        startingBalance: 0.00,
        notes: "Notes",
        isClosed: false,
        transactions: []
    )
    
    nonisolated(unsafe) static let capitalOneCard = BudgetAccountDb(
        externalID: .capitalOneCard,
        name: "Capital One Card",
        accountType: .creditCard,
        startingBalance: 0.00,
        notes: "",
        isClosed: false,
        transactions: []
    )
}
