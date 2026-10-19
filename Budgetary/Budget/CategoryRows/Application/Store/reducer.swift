//
//  reducer.swift
//  Budgetary
//
//  Created by Phillip Baker on 17/10/2026.
//

func appReducer(state: inout AppState, action: AppAction) -> [AppEffect] {
    switch action {
        
        // MARK: - Home
        
    case .tabSelected(let tab):
        guard tab != state.homeState.selectedTab else { return [] }
        state.homeState.selectedTab = tab
        return []
        
        // MARK: - Global Navigation
        
    case .transactionSheetRequested(_, let transaction): // will eventually be tabDestintion rather than AppTab
        // Optional transaction passed in. Nil = new
        // New transaction needs to be handed a non-optional account value
        state.transactionState = .loaded(
            TransactionStateData(transactionToEdit: transaction, isNewTransaction: true)
        )
        
        state.sheet = .transactionSheet
        return []
        
    case .addAccountSheetRequested:
        state.sheet = .addAccountSheet
        return []
        
    case .addAccountSheetDismissed:
        state.sheet = nil
        return []
        
    case .sheetDismissed:
        state.transactionState = .notLoaded
        state.sheet = nil
        return []
        
        // MARK: - Transaction
        
    case .saveTransactionRequested(let request):
        return [.saveTransaction(request)]
        
    case .saveTransactionSucceeded:
        state.sheet = nil
        return [.loadBudget, .loadBudgetAccounts]
        
    case .saveTransactionFailed:
        return []
        
    case .deleteTransactionRequested(_):
        return []
        
    case .deleteTransactionSucceeded:
        return []
        
    case .deleteTransactionFailed:
        return []
        
        // MARK: - Budget - Load
        
    case .loadBudgetRequested:
        guard state.budgetState.isIdle else { return [] }
        state.budgetState = .loading
        return [.loadBudget]
        
    case .loadBudgetSucceeded(let budget):
        state.budgetState = .loaded(budget)
        return []
        
    case .loadBudgetFailed:
        state.budgetState = .error(BudgetError.budgetLoadFailed)
        return []
        
        // MARK: - Budget - Filters
        
    case .budgetRowsFiltered(let filterID): // TODO: This should be local in view model?
        let filter = CategoryFilter(rawValue: filterID) ?? .allCategories
        state.filter = filter
        if filter == .allCategories && filterID != CategoryFilter.allCategories.rawValue {
            state.budgetState = .error(.invalidCategoryFilter)
        }
        return [.loadBudget]
        
    case .monthYearUpdated(let monthYear):
        if case .loaded(let budget) = state.budgetState,
           !(budget.start...budget.end).contains(monthYear) {
            return []
        }
        state.monthYear = monthYear
        return [.loadBudget]
        
        // MARK: - Budget - Category Groups
        
    case .categoryGroupUpdated(let categoryGroup):
        guard case .loaded(var budget) = state.budgetState else { return [] }
        let updatedGroups = budget.categoryGroups.map { $0.id == categoryGroup.id ? categoryGroup : $0 }
        budget.categoryGroups = updatedGroups
        state.budgetState = .loaded(budget)
        return []
        
    case .creditCardPaymentGroupUpdated(let creditCardGroup):
        guard case .loaded(var budget) = state.budgetState else { return [] }
        budget.creditCardPaymentGroup = creditCardGroup
        state.budgetState = .loaded(budget)
        return []
        
    case .newCategoryRequested(name: let name, groupID: let groupID):
        return [.createCategory(name: name, groupID: groupID)]
        
    case .createNewCategorySucceeded:
        return [.loadBudget, .loadBudgetAccounts]
        
        // MARK: - Budget - Assign Money
        
    case .assignMoneyRequested(let assignedAmount, let categoryID, let monthYear):
        return [.assignMoney(amount: assignedAmount, categoryID: categoryID, monthYear: monthYear)]
        
    case .assignMoneySucceeded:
        return [.loadBudget]
        
    case .assignMoneyFailed:
        state.budgetState = .error(BudgetError.assignMoneyFailed)
        return []
        
        // MARK: Accounts - Load
        
    case .budgetAccountsDataLoadRequested:
        guard state.accountsState.isIdle else { return [] }
        state.accountsState = .loading
        return [.loadBudgetAccounts]
        
    case .budgetAccountsDataLoaded(let accounts):
        state.accountsState = .loaded(accounts)
        return []
        
    case .budgetAccountsDataLoadFailed:
        state.accountsState = .error(.accountsLoadFailed)
        return []
        
        // MARK: - Accounts - Add Account
        
    case .addAccountRequested(name: let name, accountType: let accountType, startingBalance: let startingBalance):
        state.accountsState = .loading
        state.sheet = nil
        return [.createBudgetAccount(name: name, accountType: accountType, startingBalance: startingBalance)]
        
    case .addAccountSucceeded:
        return [.loadBudget, .loadBudgetAccounts]
        
    case .addAccountFailed:
        state.accountsState = .error(.unknownError)
        return []
        
        // MARK: Payees - Load
        
    case .payeeDataLoadRequested:
        guard state.payeesState.isIdle else { return [] }
        state.payeesState = .loading
        return [.loadPayees]
        
    case .payeeDataLoaded(let payees):
        state.payeesState = .loaded(payees)
        return []
        
    case .payeePickerDataLoadFailed:
        state.payeesState = .error(.dataError)
        return []
        
        // MARK: Payees - Add Payee
        
    case .createNewPayeeRequested(let name):
        return [.createPayee(name: name)]
        
    case .createNewPayeeSucceeded:
        return [.loadPayees]
        
    case .createNewPayeeFailed:
        return []
        
        // MARK: - Edit Categories
        
    case .newCategoryGroupRequested(let name):
        return [.createCategoryGroup(name: name)]

    case .newCategoryGroupSucceeded:
        return [.loadBudget, .loadBudgetAccounts]

    case .newCategoryGroupFailed:
        return []
    case .renameCategoryGroupRequested(_, _):
        return []
    case .renameCategoryGroupSucceeded:
        return []
    case .renameCategoryGroupFailed:
        return []
    case .renameCategoryRequested(_, _):
        return []
    case .renameCategorySucceeded:
        return []
    case .renameCategoryFailed:
        return []
    case .deleteCategoryGroupRequested(_):
        return []
    case .deleteCategoryGroupSucceeded:
        return []
    case .deleteCategoryGroupFailed:
        return []
    case .deleteCategoryRequested(_, _):
        return []
    case .deleteCategorySucceeded:
        return []
    case .deleteCategoryFailed:
        return []
    case .moveCategoryGroup(_, _):
        return []
    case .moveCategory(_, _, _):
        return []
    }
}
