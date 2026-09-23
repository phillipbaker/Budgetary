//
//  CreditCardPaymentGroupRow.swift
//  Budgetary
//
//  Created by Phillip Baker on 27/11/2025.
//

import Foundation

public struct CreditCardPaymentGroupRow: Equatable, Identifiable, Sendable {
    public let id: ID<CreditCardPaymentGroupRow>
    let name: String
    let assignedTotals: [MonthYear: Decimal]
    let activityTotals: [MonthYear: Decimal]
    let availableTotals: [MonthYear: Decimal]
    let creditCardPayments: [CreditCardPaymentRow]
}
