//
//  TransactionPresentation.swift
//  Budgetary
//
//  Created by Phillip Baker on 22/11/2024.
//

public struct TransactionPresentation: Equatable, Hashable, Identifiable, Sendable {
    public let id: String
    let date: String
    let payee: PayeePresentation?
    let category: TransactionCategoryPresentation?
    let memo: String
    let amount: AmountPresentation
    let isCleared: Bool
}
