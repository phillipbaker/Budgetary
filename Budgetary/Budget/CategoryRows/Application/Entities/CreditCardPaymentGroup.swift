//
//  CreditCardPaymentGroup.swift
//  Budgetary
//
//  Created by Phillip Baker on 08/12/2025.
//

import Foundation

public struct CreditCardPaymentGroup: Equatable, Identifiable, Sendable {
    public let id: ID<CreditCardPaymentGroup>
    let name: String
    let creditCardPayments: [CreditCardPayment]
    
    func replacing(_ creditCardPayment: CreditCardPayment) -> CreditCardPaymentGroup {
        return CreditCardPaymentGroup(
            id: self.id,
            name: self.name,
            creditCardPayments: self.creditCardPayments.map { $0.id == creditCardPayment.id ? creditCardPayment : $0 }
        )
    }
    
    func appending(_ creditCardPayment: CreditCardPayment) -> CreditCardPaymentGroup {
        return CreditCardPaymentGroup(
            id: self.id,
            name: self.name,
            creditCardPayments: self.creditCardPayments + [creditCardPayment]
        )
    }
}
