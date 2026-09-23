//
//  CreditCardPaymentGroupDb.swift
//  Budgetary
//
//  Created by Phillip Baker on 27/11/2025.
//

import Foundation
import SwiftData

@Model
final class CreditCardPaymentGroupDb: Equatable {
    @Attribute(.unique) var externalID: UUID
    var name = "Credit Card Payments"
    @Relationship(deleteRule: .cascade) var payments: [CreditCardPaymentDb]
    
    init(
        externalID: UUID,
        payments: [CreditCardPaymentDb]
    ) {
        self.externalID = externalID
        self.payments = payments
    }
}
