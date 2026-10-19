//
//  AppAction.swift
//  Budgetary
//
//  Created by Phillip Baker on 19/01/2026.
//

import Foundation

enum AppAction {
    // Home (Navigation)
    case tabSelected(AppTab)
    case transactionSheetRequested(AppTab, TransactionData?)
    case sheetDismissed
    
    // Transaction
    case saveTransactionRequested(SaveTransactionRequest)
    case saveTransactionSucceeded
    case saveTransactionFailed
    case deleteTransactionRequested(ID<TransactionDraft>)
    case deleteTransactionSucceeded
    case deleteTransactionFailed

    // Payees
    case loadPayeesRequested
    case loadPayeesSucceeded([Payee])
    case loadPayeesFailed
    case createPayeeRequested(String)
    case createPayeeSucceeded
    case createPayeeFailed

    // Budget - Load
    case loadBudgetRequested
    case loadBudgetSucceeded(BudgetData)
    case loadBudgetFailed
    
    // Budget - Filters
    case budgetRowsFiltered(String)
    case monthYearUpdated(MonthYear)
    
    // Budget - Assign Money
    case assignMoneyRequested(Decimal, BudgetRowID, MonthYear)
    case assignMoneySucceeded
    case assignMoneyFailed
    
    // Budget - Category Groups
    case categoryGroupUpdated(CategoryGroupRow)
    case creditCardPaymentGroupUpdated(CreditCardPaymentGroupRow)
    case createCategoryRequested(name: String, groupID: ID<CategoryGroup>)
    case createCategorySucceeded
    case createCategoryFailed
    case createCategoryGroupRequested(String)
    case createCategoryGroupSucceeded
    case createCategoryGroupFailed
    case renameCategoryGroupRequested(ID<CategoryGroup>, String)
    case renameCategoryGroupSucceeded
    case renameCategoryGroupFailed
    case renameCategoryRequested(ID<Category>, String)
    case renameCategorySucceeded
    case renameCategoryFailed
    case deleteCategoryGroupRequested(ID<CategoryGroup>)
    case deleteCategoryGroupSucceeded
    case deleteCategoryGroupFailed
    case deleteCategoryRequested(ID<Category>, ID<CategoryGroup>)
    case deleteCategorySucceeded
    case deleteCategoryFailed
    case moveCategoryGroupRequested(IndexSet, Int)
    case moveCategoryGroupSucceeded
    case moveCategoryGroupFailed
    case moveCategoryRequested(ID<Category>, ID<CategoryGroup>, Int)
    case moveCategorySucceeded
    case moveCategoryFailed
    
    // Budget Accounts - Load
    case loadBudgetAccountsRequested
    case loadBudgetAccountsSucceeded([AccountData])
    case loadBudgetAccountsFailed
    case createBudgetAccountRequested(name: String, accountType: BudgetAccountType, startingBalance: Decimal)
    case createBudgetAccountSucceeded
    case createBudgetAccountFailed

    // Budget Accounts
    case addAccountSheetRequested
    case addAccountSheetDismissed
}
