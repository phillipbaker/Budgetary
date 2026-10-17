//
//  AppEffect.swift
//  Budgetary
//
//  Created by Phillip Baker on 19/01/2026.
//

import Foundation

enum AppEffect: Equatable {
    // Budget
    case loadBudget
    case assignMoney(amount: Decimal, categoryID: BudgetRowID, monthYear: MonthYear)
    
    // Accounts
    case createBudgetAccount(name: String, accountType: BudgetAccountType, startingBalance: Decimal)
    case loadBudgetAccounts
    
    // Transactions
    case saveTransaction(SaveTransactionRequest)
    
    // Payees
    case loadPayees
    case createPayee(name: String)

    // Category Groups
    case createCategoryGroup(name: String)
    case createCategory(name: String, groupID: ID<CategoryGroup>)
}
