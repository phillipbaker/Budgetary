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
    var payeeId: String?
    var categoryId: String?
    var memo: String
    var amount: Amount
    var isCleared: Bool
    
    init(
        id: String,
        date: Date,
        payeeId: String?,
        categoryId: String?,
        memo: String,
        amount: Amount,
        isCleared: Bool
    ) {
        self.id = id
        self.date = date
        self.payeeId = payeeId
        self.categoryId = categoryId
        self.memo = memo
        self.amount = amount
        self.isCleared = isCleared
    }
}
