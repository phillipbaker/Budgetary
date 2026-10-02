//
//  Available.swift
//  Budgetary
//
//  Created by Phillip Baker on 19/11/2024.
//

import Foundation

public struct Available: Equatable, Hashable, Sendable {
    var total: Decimal
    let cashFromLastMonth: Decimal
    let assignedThisMonth: Decimal
    let cashSpendingThisMonth: Decimal
    let message: String
}
