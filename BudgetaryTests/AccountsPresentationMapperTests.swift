//
//  AccountsPresentationMapperTests.swift
//  Budgetary
//
//  Created by Phillip Baker on 12/11/2026.
//

import Foundation
import Testing
@testable import Budgetary

@Suite("AccountsPresentationMapper")
struct AccountsPresentationMapperTests {
    let mapper = AccountsPresentationMapper()

    @Test(arguments: ["-0.01", "-12.50", "-0.006"])
    func negativeBalanceIsNegative(balance: String) {
        #expect(mapper.map(styleFrom: Decimal(string: balance)!) == .negative)
    }

    @Test(arguments: ["0.01", "12.50", "0.006"])
    func positiveBalanceIsPositive(balance: String) {
        #expect(mapper.map(styleFrom: Decimal(string: balance)!) == .positive)
    }

    @Test("Zero, or less than half a penny either side, is zero",
          arguments: ["0", "0.004", "-0.004", "0.005"])
    func balanceThatDisplaysAsZeroIsZero(balance: String) {
        #expect(mapper.map(styleFrom: Decimal(string: balance)!) == .zero)
    }
    
    @Test("Shows a balance that rounds to zero without a minus sign",
          arguments: ["-0.004", "-0.005"])
    func roundedZeroHasNoMinusSign(balance: String) {
        let row = mapper.mapRow(account: .stub(balance: Decimal(string: balance)!))
        #expect(row.balance == "£0.00")
        #expect(row.balanceStyle == .zero)
    }
}

private extension AccountData {
    static func stub(balance: Decimal) -> AccountData {
        AccountData(
            id: .init(),
            name: "Test Account",
            type: .cash(.checking),
            isClosed: false,
            balance: balance,
            startingBalance: 0,
            transactions: []
        )
    }
}
