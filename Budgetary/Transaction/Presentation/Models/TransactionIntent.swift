//
//  TransactionIntent.swift
//  Budgetary
//
//  Created by Phillip Baker on 21/05/2025.
//

public enum TransactionIntent {
    case addTransaction
    case updateTransaction(TransactionRequestModel)
    case deleteTransaction(id: String)
}
