//
//  TransactionDate.swift
//  Budgetary
//
//  Created by Phillip Baker on 10/05/2025.
//

import Foundation

public struct TransactionDate: Equatable, Hashable, Identifiable, Sendable {
    public let id: String
    let date: Date
    let transactions: [TransactionPresentation]
}
