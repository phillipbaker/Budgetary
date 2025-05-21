//
//  TransactionPlain.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//

import Foundation

public struct TransactionPlain: Equatable, Sendable {
    let id: String
    let date: Date
    let payeeId: String?
    let categoryId: String?
    let memo: String
    let amount: Amount
    let isCleared: Bool
}
