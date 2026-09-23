//
//  CreditCardAvailable.swift
//  Budgetary
//
//  Created by Phillip Baker on 01/12/2025.
//

import Foundation

public struct CreditCardAvailable: Equatable, Hashable, Sendable {
    var total: Decimal
    let cashFromLastMonth: Decimal
    let assignedThisMonth: Decimal
    let cashSpendingThisMonth: Decimal
//    let creditSpendingThisMonth: String
    let message: String
}
