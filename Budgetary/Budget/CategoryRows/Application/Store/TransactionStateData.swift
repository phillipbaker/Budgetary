//
//  TransactionStateData.swift
//  Budgetary
//
//  Created by Phillip Baker on 19/01/2026.
//

import Foundation

public struct TransactionStateData: Equatable, Hashable, Sendable {
    var transactionToEdit: TransactionData?
    var isNewTransaction: Bool
}
