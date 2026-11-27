//
//  ActivityTests.swift
//  Budgetary
//
//  Created by Phillip Baker on 27/11/2026.
//

import Foundation
import Testing
@testable import Budgetary

@Suite("Activity")
struct ActivityTests {
    let checking = TransactionAccount(id: ID<TransactionAccount>(), name: "Checking")
    let card = TransactionAccount(id: ID<TransactionAccount>(), name: "Credit Card")

    @Test("Splits a month's activity into cash and credit")
    func splitsActivityIntoCashAndCredit() {
        let activity = Activity(
            transactions: [
                transaction(.outflow(70), on: checking),
                transaction(.inflow(10), on: checking),
                transaction(.outflow(50), on: card),
                transaction(.inflow(20), on: card)
            ],
            creditCardAccountIDs: [card.id]
        )

        #expect(activity.cashTotal == -60)
        #expect(activity.creditTotal == -30)
        #expect(activity.total == -90)
    }

    @Test("Activity with no credit card accounts is all cash")
    func activityWithoutCardsIsCash() {
        let activity = Activity(
            transactions: [transaction(.outflow(70), on: checking), transaction(.outflow(50), on: card)],
            creditCardAccountIDs: []
        )

        #expect(activity.cashTotal == -120)
        #expect(activity.creditTotal == 0)
    }

    func transaction(_ amount: Amount, on account: TransactionAccount) -> BudgetTransaction {
        BudgetTransaction(
            id: ID<BudgetTransaction>(),
            date: .now,
            memo: "",
            amount: amount,
            isCleared: false,
            payee: .regular(name: "Shop"),
            category: nil,
            account: account,
            linkedTransactionID: nil
        )
    }
}
