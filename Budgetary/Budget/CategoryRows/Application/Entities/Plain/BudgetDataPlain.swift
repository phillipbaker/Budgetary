//
//  BudgetDataPlain.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//

public struct BudgetDataPlain: Equatable, Sendable {
    let budgetPlain: BudgetPlain
    let payeesPlain: [PayeePlain]
    let budgetAccountsPlain: [BudgetAccountPlain]
    let categoryGroupsPlain: [CategoryGroupPlain]
    let creditCardPaymentGroupPlain: CreditCardPaymentGroupPlain
}
