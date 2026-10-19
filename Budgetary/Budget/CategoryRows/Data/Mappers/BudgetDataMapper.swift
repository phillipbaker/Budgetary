//
//  BudgetDataMapper.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//

public final class BudgetDataMapper: Sendable {
    func map(
        budgetPlain: BudgetPlain,
        payeesPlain: [PayeePlain],
        budgetAccountsPlain: [BudgetAccountPlain],
        categoryGroupsPlain: [CategoryGroupPlain],
        creditCardPaymentGroupPlain: CreditCardPaymentGroupPlain
    ) -> BudgetDataPlain {
        return BudgetDataPlain(
            budgetPlain: budgetPlain,
            payeesPlain: payeesPlain,
            budgetAccountsPlain: budgetAccountsPlain,
            categoryGroupsPlain: categoryGroupsPlain,
            creditCardPaymentGroupPlain: creditCardPaymentGroupPlain
        )
    }
}
