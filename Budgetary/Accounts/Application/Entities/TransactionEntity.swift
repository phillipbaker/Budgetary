//
//  TransactionEntity.swift
//  Budgetary
//
//  Created by Phillip Baker on 23/08/2024.
//

import Foundation

public struct TransactionEntity: Equatable, Hashable, Sendable {
//    /// The Account the transaction is associated with. Non-optional, transactions must belong to an Account.
//    // Need to look at other types of account to see if need different types of transactions for different types of accounts of whether this should be one transaction type and associated with an Account porotocol so I can use this transaction model for loans, tracking accounts etc... ifso then what does the Account protocol need? An array of transactions, is that it?
//    let account: BudgetAccount
    
    let id: String = UUID().uuidString
    let date: Date
    let payee: Payee? // // Default to empty string, remove optional? Does this have memory problems?
    let category: TransactionCategory?
    let memo: String = ""
    let amount: Amount
    let isCleared: Bool
    // Flag
    // Repeating transactions
}

public enum Amount: Codable, Equatable, Hashable, Sendable {
    case inflow(Decimal)
    case outflow(Decimal)
    
    var value: Decimal {
        switch self {
        case let .inflow(amount):
            return amount
        case let .outflow(amount):
            return amount
        }
    }
}
