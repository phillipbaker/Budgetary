//
//  AddBudgetAccountSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 28/11/2025.
//

public protocol AddBudgetAccountSource: Sendable {
    func add(account: BudgetAccountPlain) async
    func add(payee: PayeePlain) async
    func creditCardPaymentGroup() async -> CreditCardPaymentGroupPlain
    func update(creditCardPaymentGroup: CreditCardPaymentGroupPlain) async
}
