//
//  TransactionEntity.swift
//  Budgetary
//
//  Created by Phillip Baker on 23/08/2024.
//

import Foundation

public struct TransactionEntity: Equatable, Hashable, Sendable {
    let id: String
    let date: Date
    let memo: String
    let amount: Amount
    let isCleared: Bool
    let payee: Payee?   
    let category: TransactionCategory?
    let account: TransactionAccount

    // Flag
    // Repeating transactions
}
