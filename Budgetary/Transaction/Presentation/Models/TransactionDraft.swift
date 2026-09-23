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
    var linkedTransactionID: UUID? // only when payee type is .transfer

    init(
        id: Self.ID = .init(),
        date: Date = .now,
        memo: String = "",
        amount: AmountDraft = AmountDraft(type: .outflow, value: "0.00"),
        isCleared: Bool = false,
        payee: PayeePresentation? = nil,
        account: TransactionAccountPresentation? = nil, // TODO: I think I want a default value here i.e. always pass one in based on call site
        category: TransactionCategoryPresentation? = nil,
        linkedTransactionID: UUID? = nil // only when payee type is .transfer
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
    
    init(from transaction: TransactionPresentation) {
        self.id = ID(transaction.id)
        self.date = transaction.date
        self.memo = transaction.memo
        self.amount = AmountDraft(type: transaction.amount.type, value: transaction.amount.value)
        self.isCleared = transaction.isCleared
        self.payee = transaction.payee
        self.account = transaction.account
        self.category = transaction.category
        self.linkedTransactionID = transaction.linkedTransactionID
    }
    
    init(from transaction: TransactionPresentation?) {
        if let transaction {
            self.init(from: transaction)
        } else {
            self.init()
        }
    }
}
