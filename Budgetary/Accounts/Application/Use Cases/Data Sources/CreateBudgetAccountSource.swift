//
//  CreateBudgetAccountSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 28/11/2025.
//

public protocol CreateBudgetAccountSource: Sendable {
    func create(account: BudgetAccountPlain) async
    func create(payee: PayeePlain) async
    func loadCreditCardPaymentGroup() async -> CreditCardPaymentGroupPlain
    func update(creditCardPaymentGroup: CreditCardPaymentGroupPlain) async
}
