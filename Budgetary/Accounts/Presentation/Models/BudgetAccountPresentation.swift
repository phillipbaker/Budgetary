//
//  BudgetAccountPresentation.swift
//  Budgetary
//
//  Created by Phillip Baker on 02/05/2025.
//

public struct BudgetAccountPresentation: Equatable, Hashable, Identifiable, Sendable {
    public let id: String
    let name: String
    let startingBalance: String
    let notes: String?
    let isClosed: Bool
    let balance: String
    let transactionsByDate: [TransactionDate]
    
    public static func == (lhs: BudgetAccountPresentation, rhs: BudgetAccountPresentation) -> Bool {
        return lhs.id == rhs.id
        && lhs.name == rhs.name
        && lhs.startingBalance == rhs.startingBalance
        && lhs.notes == rhs.notes
        && lhs.isClosed == rhs.isClosed
        && lhs.balance == rhs.balance
        && lhs.transactionsByDate == rhs.transactionsByDate
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
        hasher.combine(name)
        hasher.combine(startingBalance)
        hasher.combine(notes)
        hasher.combine(isClosed)
        hasher.combine(balance)
        hasher.combine(transactionsByDate)
    }
}
