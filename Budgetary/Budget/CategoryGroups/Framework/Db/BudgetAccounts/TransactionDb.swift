//
//  TransactionDb.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//

import Foundation
import SwiftData

@Model
final class TransactionDb: Equatable {
    @Attribute(.unique) var id: String
    var date: Date
    var memo: String
    var amount: Amount
    var isCleared: Bool
    var payeeId: String?
    var categoryId: String?

    init(
        id: String,
        date: Date,
        memo: String,
        amount: Amount,
        isCleared: Bool,
        payeeId: String?,
        categoryId: String?
    ) {
        self.id = id
        self.date = date
        self.memo = memo
        self.amount = amount
        self.isCleared = isCleared
        self.categoryId = categoryId
        self.payeeId = payeeId
    }
}
