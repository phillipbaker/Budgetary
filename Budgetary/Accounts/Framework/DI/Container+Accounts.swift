//
//  Container+Accounts.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/05/2025.
//

import Factory

extension Container {
    
    // MARK: View Model
    
    @MainActor
    var accountsViewModel: Factory<AccountsViewModel> {
        self { @MainActor in AccountsViewModel() }
            .singleton
    }
    
    // MARK: Mappers
    
    var budgetAccountsMapper: Factory<BudgetAccountsMapper> {
        self { BudgetAccountsMapper() }
            .singleton
    }

    var accountsStateMapper: Factory<AccountsStateMapper> {
        self { AccountsStateMapper() }
            .singleton
    }
    
    var accountsPresentationMapper: Factory<AccountsPresentationMapper> {
        self { AccountsPresentationMapper() }
            .singleton
    }

    // MARK: Use Cases & Data Sources
    
    var loadBudgetAccountsUseCase: Factory<LoadBudgetAccountsUseCase> {
        self { LoadBudgetAccountsUseCase() }
            .singleton
    }
    
    var loadTransactionAccountsUseCase: Factory<LoadTransactionAccountsUseCase> {
        self { LoadTransactionAccountsUseCase() }
            .singleton
    }
    
    @MainActor
    var loadBudgetAccountsEffect: Factory<LoadBudgetAccountsEffect> {
        self { @MainActor in LoadBudgetAccountsEffect() }
            .singleton
    }
    
    var loadBudgetAccountsSource: Factory<LoadBudgetAccountsSource> {
        self { LoadBudgetAccountsDataSource() }
            .singleton
    }
    
    var loadTransactionAccountsSource: Factory<LoadTransactionAccountsSource> {
        self { LoadTransactionAccountsDataSource() }
            .singleton
    }
    
    var createBudgetAccountUseCase: Factory<CreateBudgetAccountUseCase> {
        self { CreateBudgetAccountUseCase() }
            .singleton
    }
    
    var createBudgetAccountSource: Factory<CreateBudgetAccountSource> {
        self { CreateBudgetAccountDataSource() }
    }
    
    @MainActor
    var addAccountViewModel: Factory<AddAccountViewModel> {
        self { @MainActor in AddAccountViewModel() }
            .singleton
    }
}
