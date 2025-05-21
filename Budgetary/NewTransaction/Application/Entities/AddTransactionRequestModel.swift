//
//  AddTransactionRequestModel.swift
//  Budgetary
//
//  Created by Phillip Baker on 21/05/2025.
//

import Foundation

struct AddTransactionRequestModel {
    let date: Date
    let amount: String
    let payeeId: String?
    let categoryId: String?
    let isCleared: Bool
    let transactionType: TransactionType
    let accountId: String?
}
