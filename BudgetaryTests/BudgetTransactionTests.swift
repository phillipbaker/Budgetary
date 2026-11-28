//
//  BudgetTransactionTests.swift
//  Budgetary
//
//  Created by Phillip Baker on 27/11/2026.
//

import Foundation
import Testing
@testable import Budgetary

@Suite("BudgetTransaction")
struct BudgetTransactionTests {
    struct KindCase: Sendable, CustomTestStringConvertible {
        let description: String
        let amount: Amount
        let isTransfer: Bool
        let isPayment: Bool
        let isRefund: Bool

        var testDescription: String { description }
    }

    @Test("Tells payments and refunds apart from charges and transfers out", arguments: [
        KindCase(description: "A charge", amount: .outflow(40), isTransfer: false, isPayment: false, isRefund: false),
        KindCase(description: "A refund", amount: .inflow(40), isTransfer: false, isPayment: false, isRefund: true),
        KindCase(description: "A payment", amount: .inflow(40), isTransfer: true, isPayment: true, isRefund: false),
        KindCase(description: "A transfer out", amount: .outflow(40), isTransfer: true, isPayment: false, isRefund: false)
    ])
    func classifiesTransaction(_ testCase: KindCase) {
        let payee: Payee = testCase.isTransfer
            ? .transfer(name: "Checking", accountID: ID<BudgetAccount>())
            : .regular(name: "Shop")
        let transaction = BudgetTransaction(
            id: ID<BudgetTransaction>(),
            date: .now,
            memo: "",
            amount: testCase.amount,
            isCleared: false,
            payee: payee,
            category: nil,
            account: TransactionAccount(id: ID<TransactionAccount>(), name: "Credit Card"),
            linkedTransactionID: nil
        )

        #expect(transaction.isTransfer == testCase.isTransfer)
        #expect(transaction.isPayment == testCase.isPayment)
        #expect(transaction.isRefund == testCase.isRefund)
    }
}
