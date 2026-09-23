//
//  CreditCardPaymentGroupPlain.swift
//  Budgetary
//
//  Created by Phillip Baker on 08/12/2025.
//

public struct CreditCardPaymentGroupPlain: Equatable, Sendable {
    let id: ID<CreditCardPaymentGroupPlain>
    let name: String
    let cardPayments: [CreditCardPaymentPlain]
}
