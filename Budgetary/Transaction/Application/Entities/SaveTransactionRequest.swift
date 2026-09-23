//
//  SaveTransactionRequest.swift
//  Budgetary
//
//  Created by Phillip Baker on 15/09/2026.
//
import Foundation

struct SaveTransactionRequest: Equatable, Hashable, Sendable {
    let id: ID<BudgetTransaction>
    let date: Date
    let memo: String
    let amount: Amount
    let isCleared: Bool
    let payeeID: ID<Payee>?
    let categoryID: ID<TransactionCategory>?
    let accountID: ID<BudgetAccount>
    let linkedTransactionID: ID<BudgetTransaction>?
}
