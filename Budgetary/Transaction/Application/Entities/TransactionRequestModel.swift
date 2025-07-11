//
//  TransactionRequestModel.swift
//  Budgetary
//
//  Created by Phillip Baker on 21/05/2025.
//

import Foundation

public struct TransactionRequestModel {
    let id: String?
    var date: Date
    var memo: String
    var amount: String
    var isCleared: Bool
    var transactionType: TransactionType
    var payee: PayeePresentation?
    var category: TransactionCategoryPresentation?
    var account: TransactionAccountPresentation?
}
