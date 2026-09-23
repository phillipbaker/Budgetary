//
//  Activity.swift
//  Budgetary
//
//  Created by Phillip Baker on 19/11/2024.
//

import Foundation

public struct Activity: Equatable, Hashable, Sendable {
    let total: Decimal
    let transactions: [BudgetTransaction]
}
