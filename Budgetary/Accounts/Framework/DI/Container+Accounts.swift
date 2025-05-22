//
//  Container+Accounts.swift
//  Budgetary
//
//  Created by Phillip Baker on 04/05/2025.
//

import Factory

extension Container {
    
    // MARK: View Model
    
    var accountsViewModel: Factory<AccountsViewModel> {
        self { AccountsViewModel() }
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
    
    var getAccountsStreamUseCase: Factory<GetAccountsStreamUseCase> {
        self { GetAccountsStreamUseCase() }
            .singleton
    }
    
    var getAccountsStreamSource: Factory<GetAccountsStreamSource> {
        self { GetAccountsStreamDataSource() }
            .singleton
    }
}
