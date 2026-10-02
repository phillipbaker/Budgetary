//
//  BudgetAccount.swift
//  Budgetary
//
//  Created by Phillip Baker on 23/08/2024.
//

import Foundation

public struct BudgetAccount: Equatable, Hashable, Sendable {
    let id: ID<BudgetAccount>
    let name: String
    let type: BudgetAccountType
    
    /// The current balance when adding an account. Non-optional, defaults to zero.
    let startingBalance: Decimal
    
    /// Optional notes associated with the account.
    let notes: String?
    
    /// Boolean value for whether or not an account has been “closed” and no longer appears in the budget calculation
    // TODO: Need to know what calculations to perform when closing an account...
    let isClosed: Bool
    
    /// All transactions that belong to the account. Non-optional, defaults to empty.
    let transactions: [BudgetTransaction]
    
    var transactionTotal: Decimal {
        /// Sum of all inflow and outflow transactions
        /// Maps transactions to add or subtract amount
        let amounts: [Decimal] = transactions.map { transaction in
            switch transaction.amount {
            case .inflow(let amount):
                return amount
            case .outflow(let amount):
                return -amount
            }
        }
        
        return amounts.reduce(0.00, +)
    }
    
    var balance: Decimal {
        return startingBalance + transactionTotal
    }
    
    /// Sum of uncleared transactions
    var uncleared: Decimal {
        let amounts: [Decimal] = transactions
            .filter { !$0.isCleared }
            .map {
                switch $0.amount {
                case .inflow(let amount):
                    return amount
                case .outflow(let amount):
                    return -amount
                }
            }
        return amounts.reduce(0.00, +)
    }
    
    var cleared: Decimal {
        return transactionTotal - uncleared
    }
    
    /// Working balance provides the actual value for available funds.
    var workingBalance: Decimal {
        cleared - uncleared
    }
    
    init(
        id: ID<BudgetAccount>,
        name: String,
        type: BudgetAccountType,
        startingBalance: Decimal = 0.00,
        notes: String? = nil,
        isClosed: Bool = false,
        transactions: [BudgetTransaction] = []
    ) {
        self.id = id
        self.name = name
        self.type = type
        self.startingBalance = startingBalance
        self.notes = notes
        self.isClosed = isClosed
        self.transactions = transactions
    }
    
    func upserting(transaction: BudgetTransaction) -> BudgetAccount {
        var updatedTransactions: [BudgetTransaction]
        
        if self.transactions.contains(where: { $0.id == transaction.id }) {
            updatedTransactions = self.transactions.map { $0.id == transaction.id ? transaction : $0 }
        } else {
            updatedTransactions = self.transactions + [transaction]
        }
        
        return BudgetAccount(
            id: self.id,
            name: self.name,
            type: self.type,
            startingBalance: self.startingBalance,
            notes: self.notes,
            isClosed: self.isClosed,
            transactions: updatedTransactions
        )
    }
    
    func deleting(transactionID: ID<BudgetTransaction>) -> BudgetAccount {
        return BudgetAccount(
            id: self.id,
            name: self.name,
            type: self.type,
            startingBalance: self.startingBalance,
            notes: self.notes,
            isClosed: self.isClosed,
            transactions: self.transactions.filter { $0.id != transactionID }
        )
    }
}
