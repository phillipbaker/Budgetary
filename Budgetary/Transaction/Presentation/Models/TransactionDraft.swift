//
//  TransactionDraft.swift
//  Budgetary
//
//  Created by Phillip Baker on 21/05/2025.
//

import Foundation

public struct TransactionDraft: Equatable, Hashable, Identifiable, Sendable {
    public let id: ID<TransactionDraft>
    var date: Date
    var memo: String
    var amount: AmountDraft
    var isCleared: Bool
    var payee: PayeePresentation?
    var account: TransactionAccountPresentation?
    var category: TransactionCategoryPresentation?
    let linkedTransactionID: Self.ID? // only when payee type is .transfer

    init(
        id: Self.ID = .init(),
        date: Date = .now,
        memo: String = "",
        amount: AmountDraft = AmountDraft(type: .outflow, value: 0.00),
        isCleared: Bool = false,
        payee: PayeePresentation? = nil,
        account: TransactionAccountPresentation? = nil,
        category: TransactionCategoryPresentation? = nil,
        linkedTransactionID: Self.ID? = nil // only when payee type is .transfer
    ) {
        self.id = id
        self.date = date
        self.memo = memo
        self.amount = amount
        self.isCleared = isCleared
        self.payee = payee
        self.account = account
        self.category = category
        self.linkedTransactionID = linkedTransactionID
    }
}
