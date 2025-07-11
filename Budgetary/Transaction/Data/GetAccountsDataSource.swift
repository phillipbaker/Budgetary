//
//  GetAccountsDataSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 21/05/2025.
//

import Factory

final class GetAccountsDataSource: GetAccountsSource {
    let budgetAccountsDataSourceLocal: any BudgetAccountsDataSourceLocal = Container.shared.budgetAccountsDataSourceLocal()
    
    func allAccounts() async -> [BudgetAccountPlain] {
        await budgetAccountsDataSourceLocal.allBudgetAccounts()
    }
}
