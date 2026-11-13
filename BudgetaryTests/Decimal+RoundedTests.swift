//
//  Decimal+RoundedTests.swift
//  Budgetary
//
//  Created by Phillip Baker on 12/11/2026.
//

import Testing
import Foundation
@testable import Budgetary

@Suite("Decimal.rounded(scale:)")
struct DecimalRoundedTests {
    static let cases: [(input: String, expected: String)] = [
        ("0.004", "0"),
        ("0.006", "0.01"),
        ("-0.004", "0"),
        ("-0.006", "-0.01"),
        ("0.005", "0"),       // half rounds to even (down)
        ("0.015", "0.02"),    // half rounds to even (up)
        ("1.234", "1.23"),
    ]
    
    @Test("Rounds to two places, halves to even", arguments: cases)
    func roundsToTwoPlaces(input: String, expected: String) {
        let value = Decimal(string: input)!
        #expect(value.rounded(scale: 2) == Decimal(string: expected)!)
    }
    
    @Test("Matches the currency formatter at halfway values",
          arguments: ["0.005", "0.015", "0.025"])
    func matchesCurrencyFormatter(input: String) {
        let value = Decimal(string: input)!
        #expect(value.rounded(scale: 2).formatted(.currency(code: "GBP"))
                == value.formatted(.currency(code: "GBP")))
    }
}
