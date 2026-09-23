//
//  CreditCardPaymentPlain.swift
//  Budgetary
//
//  Created by Phillip Baker on 12/11/2025.
//

import Foundation

public struct CreditCardPaymentPlain: Equatable, Sendable {
    let id: ID<CreditCardPaymentPlain>
    let name: String
    let isHidden: Bool
    let assigned: [MonthYear: Decimal]
    let accountID: UUID
}
