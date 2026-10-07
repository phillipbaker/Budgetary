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
                sheet: nil,
                tabDestinations: [.budget: [], .accounts: []]
            ),
            payeesState: .notLoaded,
            budgetState: .notLoaded,
            accountsState: .notLoaded,
            transactionState: .notLoaded,
            monthYear: .currentMonthYear,
            filter: .allCategories,
            tabDestinations: [.budget: [], .accounts: []],
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
        
    case .push(let tab, let destination):
        state.homeState.selectedTab = tab // TODO: Is this necessary?
        state.tabDestinations[tab]?.append(destination)
        return []
        
    case .pop(let tab):
        state.tabDestinations[tab]?.removeLast()
        return []
        
    case .popToRoot(let tab):
        state.tabDestinations[tab]?.removeAll()
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
        
    case .newCategoryRequested(name: let name, groupID: let groupID):
        return [NewCategoryEffect(name: name, groupID: groupID)]
        
    case .createNewCategorySucceeded:
        return [Container.shared.loadBudgetEffect(), Container.shared.loadBudgetAccountsEffect()]
        
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
        
    case .budgetAccountsDataLoadRequested:
        guard state.accountsState.isIdle else { return [] }
        state.accountsState = .loading
        return [Container.shared.loadBudgetAccountsEffect()]
        
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
        return [AddBudgetAccountEffect(name: name, accountType: accountType, startingBalance: startingBalance)]
        
    case .addAccountSucceeded:
        return [Container.shared.loadBudgetAccountsEffect(), Container.shared.loadBudgetEffect()]
        
    case .addAccountFailed:
        state.accountsState = .error(.unknownError)
        return []
        
        // MARK: Payees - Load
        
    case .payeeDataLoadRequested:
        guard state.payeesState.isIdle else { return [] }
        state.payeesState = .loading
        return [LoadPayeesEffect()]
        
    case .payeeDataLoaded(let payees):
        state.payeesState = .loaded(payees)
        return []
        
    case .payeePickerDataLoadFailed:
        state.payeesState = .error(.dataError)
        return []
        
        // MARK: Payees - Add Payee
        
    case .createNewPayeeRequested(let name):
        return [NewPayeeEffect(name: name)]
        
    case .createNewPayeeSucceeded:
        return [Container.shared.loadBudgetEffect(), Container.shared.loadBudgetAccountsEffect()]
        
    case .createNewPayeeFailed:
        return []
        
        // MARK: - Edit Categories
        
    case .newCategoryGroupRequested(let name):
        return [NewGroupEffect(name: name)]

    case .newCategoryGroupSucceeded:
        return [Container.shared.loadBudgetEffect(), Container.shared.loadBudgetAccountsEffect()]
        
        
        
    case .newCategoryGroupFailed:
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
    case .moveCategoryGroup(_, _):
        return []
    case .moveCategory(_, _, _):
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
