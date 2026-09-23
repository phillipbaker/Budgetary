//
//  CategoryActivityPresentation.swift
//  Budgetary
//
//  Created by Phillip Baker on 03/12/2025.
//

public struct CategoryActivityPresentation: ActivityPresentation, Equatable, Sendable {
    public let activityTotal: String
    public let transactions: [TransactionPresentation]
}
