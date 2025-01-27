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
    /// The date of the transaction.
    /// Does this need to stay a Date and be converted to a day in code to account for global/timezone differences?
    /// I think yes, a speciicc moment in time might be different day for different people...
    let date: Date

    /// The entity the transaction pays. Nil represents the user has not entered a Payee.
    // Default to empty string, remove optional? Does this have memory problems?
    let payee: Payee?
    
    /// The user-defined Category for a transaction. Nil equates to “Uncategorised”.
    let category: TransactionCategory
    
    /// A note field assocated with the transaction. Defaults to an empty String to avoid an Optional
    let memo: String = ""
    
    /// Value of inflow OR outflow for the transaction. Associated value of`Decimal`
    let amount: Amount
    
    /// Whether or not the transaction is cleared.
    let isCleared: Bool
    
    /// Not included in initial model
    // Flag
    // Repeating transactions
}

/// TransactionEntity value. Can be a credit OR debit with assocated value of the amount
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
