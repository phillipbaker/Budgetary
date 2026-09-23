//
//  CreditCardActivityPresentation.swift
//  Budgetary
//
//  Created by Phillip Baker on 11/11/2025.
//

import Foundation

public struct CreditCardActivityPresentation: ActivityPresentation, Equatable, Hashable, Sendable {
    let spending: String
    let returns: String
    let totalSpending: String
    let fundedSpending: String
    let paymentsAndReturns: String
    public var activityTotal: String
    public var transactions: [TransactionPresentation]
}
