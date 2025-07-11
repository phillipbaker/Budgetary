//
//  AmountPresentation.swift
//  Budgetary
//
//  Created by Phillip Baker on 02/05/2025.
//

import Foundation

public struct AmountPresentation: Equatable, Hashable, Sendable {
    let transactionType: TransactionType
    let value: String
}

enum TransactionType: String, CaseIterable, Equatable, Hashable, Identifiable, Sendable {
    case outflow, inflow
    var id: String { rawValue }
}
