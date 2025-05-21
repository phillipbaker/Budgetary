//
//  BudgetAccountsDbPreviewData.swift
//  Budgetary
//
//  Created by Phillip Baker on 28/11/2024.
//

import Foundation

extension Array where Element == BudgetAccountDb {
    static let mock = [BudgetAccountDb.hsbcChecking, .account2, .account3, .account4]
}

extension BudgetAccountDb: @unchecked Sendable {
    static let hsbcChecking = BudgetAccountDb(
        id: "1",
        nickname: "HSBC Checking",
        accountType: .budget,
        startingBalance: 0.0,
        notes: "Notes go here...",
        isClosed: false,
        transactions: [
            TransactionDb(
                id: "97",
                date: .sepEigth2024,
                payeeId: "4",
                categoryId: "99",
                memo: "Memo goes here...",
                amount: .inflow(100),
                isCleared: true
            ),
            TransactionDb(
                id: "98",
                date: .octEigth2024,
                payeeId: "4",
                categoryId: "99",
                memo: "Memo goes here...",
                amount: .inflow(100),
                isCleared: true
            ),
            TransactionDb(
                id: "99",
                date: .novEigth2024,
                payeeId: "4",
                categoryId: "99",
                memo: "Memo goes here...",
                amount: .inflow(1000),
                isCleared: true
            ),
            TransactionDb(
                id: "100",
                date: .decEigth2024,
                payeeId: "4",
                categoryId: "99",
                memo: "Memo goes here...",
                amount: .inflow(100),
                isCleared: true
            ),
            TransactionDb(
                id: "1",
                date: .octEigth2024,
                payeeId: "1",
                categoryId: "1",
                memo: "Memo goes here...",
                amount: .outflow(40),
                isCleared: true
            ),
            TransactionDb(
                id: "2",
                date: .novEigth2024,
                payeeId: "1",
                categoryId: "1",
                memo: "Memo goes here...",
                amount: .outflow(500),
                isCleared: true
            )
//            TransactionDb(
//                id: "3",
//                date: .octEigth2024,
//                payeeId: "1",
//                categoryId: "1",
//                memo: "Memo goes here...",
//                amount: .outflow(2350),
//                isCleared: true
//            ),
//            TransactionDb(
//                id: "4",
//                date: .augEigth2024,
//                payeeId: "2",
//                categoryId: "2",
//                memo: "No memo...",
//                amount: .outflow(300),
//                isCleared: true
//            ),
//            TransactionDb(
//                id: "5",
//                date: .sepEigth2024,
//                payeeId: "2",
//                categoryId: "2",
//                memo: "No memo...",
//                amount: .outflow(300),
//                isCleared: true
//            ),
//            TransactionDb(
//                id: "6",
//                date: .octEigth2024,
//                payeeId: "2",
//                categoryId: "2",
//                memo: "",
//                amount: .outflow(300),
//                isCleared: true
//            ),
        ]
    )
    
    static let account2 = BudgetAccountDb(
        id: "2",
        nickname: "Account 2",
        accountType: .budget,
        startingBalance: 0.00,
        notes: "Notes",
        isClosed: false,
        transactions: []
    )
    
    static let account3 = BudgetAccountDb(
        id: "3",
        nickname: "Account 3",
        accountType: .budget,
        startingBalance: 0.00,
        notes: "Notes",
        isClosed: false,
        transactions: []
    )
    
    static let account4 = BudgetAccountDb(
        id: "4",
        nickname: "Account 4",
        accountType: .budget,
        startingBalance: 0.00,
        notes: "Notes",
        isClosed: false,
        transactions: []
    )
}
