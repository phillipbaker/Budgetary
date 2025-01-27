//
//  AccountsTransactionsPayees.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/11/2024.
//
public struct CombinedBudgetData: Equatable, Sendable {
    let budgetPlain: BudgetPlain
    let payeesPlain: [PayeePlain]
    let budgetAccountsPlain: [BudgetAccountPlain]
    let categoryGroupsPlain: [CategoryGroupPlain]
}
