//
//  CreditCardPaymentGroupDataSourceLocal.swift
//  Budgetary
//
//  Created by Phillip Baker on 28/11/2025.
//

import Foundation

public protocol CreditCardPaymentGroupDataSourceLocal: Sendable {    
    func creditCardPaymentGroup() async -> CreditCardPaymentGroupPlain
    func update(creditCardPaymentGroup: CreditCardPaymentGroupPlain) async
}
