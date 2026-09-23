//
//  AccountsData.swift
//  Budgetary
//
//  Created by Phillip Baker on 19/01/2026.
//

import Foundation

public struct AccountData: Equatable, Hashable, Identifiable, Sendable {
    public let id: ID<AccountData>
    var name: String
    var type: BudgetAccountType
    var notes: String?
    var isClosed: Bool
    var balance: Decimal
    var startingBalance: Decimal
    var transactions: [TransactionData]
}
