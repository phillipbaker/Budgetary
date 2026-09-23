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
    @Attribute(.unique) var externalID: UUID
    var date: Date
    var memo: String
    var amount: Amount
    var isCleared: Bool
    var payeeID: ID<PayeeDb>?
    var categoryID: ID<CategoryDb>?

    init(
        externalID: UUID,
        date: Date,
        memo: String,
        amount: Amount,
        isCleared: Bool,
        payeeID: ID<PayeeDb>?,
        categoryID: ID<CategoryDb>?
    ) {
        self.externalID = externalID
        self.date = date
        self.memo = memo
        self.amount = amount
        self.isCleared = isCleared
        self.categoryID = categoryID
        self.payeeID = payeeID
    }
}
