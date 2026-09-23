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
    case push(AppTab, Destination)
    case pop(AppTab)
    case popToRoot(AppTab)
    
    // Transaction
    case saveTransactionRequested(SaveTransactionRequest)
    case saveTransactionSucceeded
    case saveTransactionFailed
    case deleteTransactionRequested(ID<TransactionDraft>)
    case deleteTransactionSucceeded
    case deleteTransactionFailed

    // Payees
    case payeeDataLoadRequested
    case payeeDataLoaded([Payee])
    case payeePickerDataLoadFailed
    case createNewPayeeRequested(String)
    case createNewPayeeSucceeded
    case createNewPayeeFailed

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
    case newCategoryRequested(name: String, groupID: ID<CategoryGroup>)
    case createNewCategorySucceeded
    case newCategoryGroupRequested(String)
    case newCategoryGroupSucceeded
    case newCategoryGroupFailed
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
    case moveCategoryGroup(IndexSet, Int)
    case moveCategory(ID<Category>, ID<CategoryGroup>, Int)
    
    // Budget Accounts - Load
    case budgetAccountsDataLoadRequested
    case budgetAccountsDataLoaded([AccountData])
    case budgetAccountsDataLoadFailed
    case addAccountSheetDismissed
    case addAccountRequested(name: String, accountType: BudgetAccountType, startingBalance: Decimal)
    case addAccountSucceeded
    case addAccountFailed

    // Budget Accounts
    case addAccountSheetRequested
}
