//
//  AddAccountAction.swift
//  Budgetary
//
//  Created by Phillip Baker on 29/01/2026.
//

public enum AddAccountAction: Sendable {
    case addAccountCancelButtonTapped
    case addAccountSaveButtonTapped(name: String, accountType: BudgetAccountTypePresentation?, startingBalance: String)
}
