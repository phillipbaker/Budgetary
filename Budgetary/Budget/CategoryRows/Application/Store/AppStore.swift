//
//  AppStore.swift
//  Budgetary
//
//  Created by Phillip Baker on 12/01/2026.
//

import Factory

@MainActor
final class AppStore {
    private var state: AppState
    private let reducer: (inout AppState, AppAction) -> [AppEffect]
    private let effectRunner: EffectRunner
    private var continuations: [UUID: AsyncStream<AppState>.Continuation] = [:]
    
    init(
        state: AppState = AppState(
            homeState: .init(
                selectedTab: .budget,
                sheet: nil
            ),
            payeesState: .notLoaded,
            budgetState: .notLoaded,
            accountsState: .notLoaded,
            transactionState: .notLoaded,
            monthYear: .currentMonthYear,
            filter: .allCategories,
            sheet: nil,
            currencyCode: "GBP"
        ),
        reducer: @escaping (inout AppState, AppAction) -> [AppEffect],
        effectRunner: EffectRunner = Container.shared.effectRunner()
    ) {
        self.state = state
        self.reducer = reducer
        self.effectRunner = effectRunner
        broadcast(state)
    }
    
    func dispatch(_ action: AppAction) {
        let effects = reducer(&state, action)
        effectRunner.run(effects)
        broadcast(state)
    }
    
    func currentState() -> AppState {
        state
    }

    func observe() -> AsyncStream<AppState> {
        AsyncStream { continuation in
            let token = UUID()
            // Register and yield on the MainActor to avoid cross-actor mutations
            Task { @MainActor in
                self.continuations[token] = continuation
                // Immediately send current state to new subscriber
                continuation.yield(self.state)
            }
            
            continuation.onTermination = { _ in
                // Hop back to the MainActor for mutation
                Task { @MainActor in
                    self.continuations[token] = nil
                }
            }
        }
    }
    
    func broadcast(_ state: AppState) {
        for continuation in continuations.values {
            continuation.yield(state)
        }
    }
}

// Put this somewhere and remove the @MainActor - it is there to silence warning because it is global
// Only store should be @MainActor
import Foundation
import Factory

@MainActor let appReducer: (inout AppState, AppAction) -> [AppEffect] = {
    state,
    action in
    switch action {
        
        // MARK: - Home
        
    case .tabSelected(let tab):
        guard tab != state.homeState.selectedTab else { return [] }
        state.homeState.selectedTab = tab
        return []
        
        // MARK: - Global Navigation
        
    case .transactionSheetRequested(let tab, let transaction): // will eventually be tabDestintion rather than AppTab
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
        return [SaveTransactionEffect(request: request)]
        
    case .saveTransactionSucceeded:
        state.sheet = nil
        return [Container.shared.loadBudgetEffect(), Container.shared.loadBudgetAccountsEffect()]
        
    case .saveTransactionFailed:
        return []
        
    case .deleteTransactionRequested(let id):
        return []
        
    case .deleteTransactionSucceeded:
        return []
        
    case .deleteTransactionFailed:
        return []
        
        // MARK: - Budget - Load
        
    case .loadBudgetRequested:
        guard state.budgetState.isIdle else { return [] }
        state.budgetState = .loading
        return [Container.shared.loadBudgetEffect()]
        
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
        return [Container.shared.loadBudgetEffect()]
        
    case .monthYearUpdated(let monthYear):
        if case .loaded(let budget) = state.budgetState,
           !(budget.start...budget.end).contains(monthYear) {
            return []
        }
        state.monthYear = monthYear
        return [Container.shared.loadBudgetEffect()]
        
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
        
    case .createCategoryRequested(name: let name, groupID: let groupID):
        return [CreateCategoryEffect(name: name, groupID: groupID)]
        
    case .createCategorySucceeded:
        return [Container.shared.loadBudgetEffect(), Container.shared.loadBudgetAccountsEffect()]
        
    case .createCategoryFailed:
        return []

        // MARK: - Budget - Assign Money
        
    case .assignMoneyRequested(let assignedAmount, let categoryID, let monthYear):
        return [AssignMoneyEffect(
            assignedAmount: assignedAmount,
            categoryID: categoryID,
            monthYear: monthYear
        )]
        
    case .assignMoneySucceeded:
        return [Container.shared.loadBudgetEffect()]
        
    case .assignMoneyFailed:
        state.budgetState = .error(BudgetError.assignMoneyFailed)
        return []
        
        // MARK: Accounts - Load
        
    case .loadBudgetAccountsRequested:
        guard state.accountsState.isIdle else { return [] }
        state.accountsState = .loading
        return [Container.shared.loadBudgetAccountsEffect()]
        
    case .loadBudgetAccountsSucceeded(let accounts):
        state.accountsState = .loaded(accounts)
        return []
        
    case .loadBudgetAccountsFailed:
        state.accountsState = .error(.accountsLoadFailed)
        return []
        
        // MARK: - Accounts - Add Account
        
    case .createBudgetAccountRequested(name: let name, accountType: let accountType, startingBalance: let startingBalance):
        state.accountsState = .loading
        state.sheet = nil
        return [CreateBudgetAccountEffect(name: name, accountType: accountType, startingBalance: startingBalance)]
        
    case .createBudgetAccountSucceeded:
        return [Container.shared.loadBudgetAccountsEffect(), Container.shared.loadBudgetEffect()]
        
    case .createBudgetAccountFailed:
        state.accountsState = .error(.unknownError)
        return []
        
        // MARK: Payees - Load
        
    case .loadPayeesRequested:
        guard state.payeesState.isIdle else { return [] }
        state.payeesState = .loading
        return [LoadPayeesEffect()]
        
    case .loadPayeesSucceeded(let payees):
        state.payeesState = .loaded(payees)
        return []
        
    case .loadPayeesFailed:
        state.payeesState = .error(.dataError)
        return []
        
        // MARK: Payees - Add Payee
        
    case .createPayeeRequested(let name):
        return [CreatePayeeEffect(name: name)]
        
    case .createPayeeSucceeded:
        return [LoadPayeesEffect()]
        
    case .createPayeeFailed:
        return []
        
        // MARK: - Edit Categories
        
    case .createCategoryGroupRequested(let name):
        return [CreateCategoryGroupEffect(name: name)]

    case .createCategoryGroupSucceeded:
        return [Container.shared.loadBudgetEffect(), Container.shared.loadBudgetAccountsEffect()]
        
        
        
    case .createCategoryGroupFailed:
        return []
    case .renameCategoryGroupRequested(let groupID, let newName):
        return []
    case .renameCategoryGroupSucceeded:
        return []
    case .renameCategoryGroupFailed:
        return []
    case .renameCategoryRequested(let categoryID, let newName):
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
    case .moveCategoryGroupRequested(_, _):
        return []
    case .moveCategoryGroupSucceeded:
        return []
    case .moveCategoryGroupFailed:
        return []
    case .moveCategoryRequested(_, _, _):
        return []
    case .moveCategorySucceeded:
        return []
    case .moveCategoryFailed:
        return []
    }
}

import SwiftUI
extension AppStore {
    func binding<Value>(
        get: @escaping (AppState) -> Value,
        send: @escaping (Value) -> AppAction
    ) -> Binding<Value> {
        Binding(
            get: { get(self.state) },
            set: { self.dispatch(send($0)) }
        )
    }
    
    func readOnlyBinding<Value>(
        _ get: @escaping (AppState) -> Value
    ) -> Binding<Value> {
        Binding(
            get: { get(self.state) },
            set: { _ in /* do nothing */ }
        )
    }
}
