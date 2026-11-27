//
//  AvailableTests.swift
//  Budgetary
//
//  Created by Phillip Baker on 27/11/2026.
//

import Foundation
import Testing
@testable import Budgetary

@Suite("Available")
struct AvailableTests {
    struct OverspendingCase: Sendable, CustomTestStringConvertible {
        let description: String
        var fromLastMonth: Decimal = 0
        var assigned: Decimal = 0
        var cashActivity: Decimal = 0
        var creditActivity: Decimal = 0
        let cashOverspending: Decimal
        let creditOverspending: Decimal

        var testDescription: String { description }
    }

    @Test(
        "Splits overspending into cash and credit, funding cash first",
        arguments: [
            OverspendingCase(
                description: "Not overspent",
                assigned: 100,
                cashActivity: -30,
                creditActivity: -20,
                cashOverspending: 0,
                creditOverspending: 0
            ),
            OverspendingCase(
                description: "Overspent in cash only",
                assigned: 50,
                cashActivity: -80,
                cashOverspending: 30,
                creditOverspending: 0
            ),
            OverspendingCase(
                description: "Overspent on a card only",
                creditActivity: -150,
                cashOverspending: 0,
                creditOverspending: 150
            ),
            OverspendingCase(
                description: "Cash covered, card overspent",
                assigned: 100,
                cashActivity: -70,
                creditActivity: -50,
                cashOverspending: 0,
                creditOverspending: 20
            ),
            OverspendingCase(
                description: "Cash and card both overspent",
                assigned: 50,
                cashActivity: -70,
                creditActivity: -30,
                cashOverspending: 20,
                creditOverspending: 30
            ),
            OverspendingCase(
                description: "A card refund covers cash overspending",
                assigned: 50,
                cashActivity: -80,
                creditActivity: 20,
                cashOverspending: 10,
                creditOverspending: 0
            ),
            OverspendingCase(
                description: "Money from last month covers cash spending",
                fromLastMonth: 50,
                cashActivity: -70,
                cashOverspending: 20,
                creditOverspending: 0
            )
        ]
    )
    func splitsOverspending(_ testCase: OverspendingCase) {
        let available = Available(
            cashFromLastMonth: testCase.fromLastMonth,
            assignedThisMonth: testCase.assigned,
            cashActivityThisMonth: testCase.cashActivity,
            creditActivityThisMonth: testCase.creditActivity,
            message: ""
        )

        #expect(available.cashOverspending == testCase.cashOverspending)
        #expect(available.creditOverspending == testCase.creditOverspending)
        #expect(available.cashOverspending + available.creditOverspending == max(-available.total, 0))
    }
}
