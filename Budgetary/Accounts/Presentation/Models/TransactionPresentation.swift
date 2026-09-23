//
//  TransactionPresentation.swift
//  Budgetary
//
//  Created by Phillip Baker on 22/11/2024.
//

import Foundation

public struct TransactionPresentation: Equatable, Hashable, Identifiable, Sendable {
    public let id: ID<TransactionPresentation>
    let date: Date
    let memo: String
    let amount: AmountPresentation
    let isCleared: Bool
    let payee: PayeePresentation?
    let category: TransactionCategoryPresentation? 
    let account: TransactionAccountPresentation
    let linkedTransactionID: UUID?
}
