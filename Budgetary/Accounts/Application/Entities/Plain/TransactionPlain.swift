//
//  TransactionPlain.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//

import Foundation

public struct TransactionPlain: Equatable, Sendable {
    let id: ID<TransactionPlain>
    let date: Date
    let memo: String
    let amount: Amount
    let isCleared: Bool
    let payeeID: ID<PayeePlain>?
    let categoryID: ID<CategoryPlain>?
}
