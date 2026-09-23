//
//  CreditCardGroupPreviewData.swift
//  Budgetary
//
//  Created by Phillip Baker on 08/12/2025.
//

import Foundation

extension CreditCardPaymentGroupRow {
    static let creditCards = CreditCardPaymentGroupRow(
        id: .init(),
        name: "Credit Card Payments",
        assignedTotals: [:],
        activityTotals: [:],
        availableTotals: [:],
        creditCardPayments: [.chaseCard]
    )
}
