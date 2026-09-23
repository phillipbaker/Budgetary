//
//  CreditCardPaymentRow.swift
//  Budgetary
//
//  Created by Phillip Baker on 11/11/2025.
//

import Foundation

public struct CreditCardPaymentRow: Equatable, Hashable, Identifiable, Sendable {
    public let id: ID<CreditCardPaymentRow>
    let name: String
    let isHidden: Bool
    let assigned: [MonthYear: CreditCardAssigned]
    let activity: [MonthYear: CreditCardActivity]
    let available: [MonthYear: CreditCardAvailable]
}
