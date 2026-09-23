//
//  CreditCardAssigned.swift
//  Budgetary
//
//  Created by Phillip Baker on 11/11/2025.
//

import Foundation

public struct CreditCardAssigned: Equatable, Hashable, Sendable {
    let assignedThisMonth: Decimal
    let assignedLastMonth: Decimal
    let averageAssigned: Decimal
    let paidLastMonth: Decimal
    let averagePaid: Decimal
}
