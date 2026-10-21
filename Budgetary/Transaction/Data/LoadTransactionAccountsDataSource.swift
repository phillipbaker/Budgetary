//
//  LoadTransactionAccountsDataSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 18/10/2026.
//

import Factory

final class LoadTransactionAccountsDataSource: LoadTransactionAccountsSource {
    let budgetAccountsDataSourceLocal: any BudgetAccountsDataSourceLocal = Container.shared.budgetAccountsDataSourceLocal()
    
    func loadTransactionAccounts() async -> [BudgetAccountPlain] {
        await budgetAccountsDataSourceLocal.loadBudgetAccounts()
    }
}
