//
//  CreditCardGroupPlain.swift
//  Budgetary
//
//  Created by Phillip Baker on 27/11/2025.
//

public struct CreditCardGroupPlain: Equatable, Sendable {
    let id: ID<CreditCardGroupPlain>
    let name: String
    let payments: [CreditCardPaymentPlain]
}
