//
//  BudgetAccountPlain.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//

import Foundation

public struct BudgetAccountPlain: Equatable, Sendable {
    let id: ID<BudgetAccountPlain>
    let name: String
    let accountType: BudgetAccountTypePlain
    let startingBalance: Decimal
    let notes: String?
    let isClosed: Bool
    let transactions: [TransactionPlain]
}

enum BudgetAccountTypePlain: Equatable, Hashable, Sendable {
    case cash
    case checking
    case savings
    case creditCard
}
