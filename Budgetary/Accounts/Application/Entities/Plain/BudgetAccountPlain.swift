//
//  BudgetAccountPlain.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//

import Foundation

public struct BudgetAccountPlain: Equatable, Sendable {
    let id: String
    let name: String
    let accountType: AccountType
    let startingBalance: Decimal
    let notes: String?
    let isClosed: Bool
    let transactions: [TransactionPlain]
}
