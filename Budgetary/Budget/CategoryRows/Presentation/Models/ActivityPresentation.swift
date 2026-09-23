//
//  ActivityPresentation.swift
//  Budgetary
//
//  Created by Phillip Baker on 19/11/2024.
//

public protocol ActivityPresentation: Equatable, Sendable {
    var activityTotal: String { get }
    var transactions: [TransactionPresentation] { get }
}
