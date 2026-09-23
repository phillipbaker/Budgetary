//
//  GetAccountsDataSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 21/05/2025.
//

import Factory

final class LoadAccountsDataSource: LoadBudgetAccountsSource {
    let budgetAccountsDataSourceLocal: any BudgetAccountsDataSourceLocal = Container.shared.budgetAccountsDataSourceLocal()
    let categoryGroupsDataSourceLocal: any CategoryGroupsDataSourceLocal = Container.shared.categoryGroupsDataSourceLocal()
    let payeesDataSourceLocal: any PayeesDataSourceLocal = Container.shared.payeesDataSourceLocal()
    
    func accounts() async -> [BudgetAccountPlain] {
        await budgetAccountsDataSourceLocal.accounts()
    }
    
    func categoryGroups() async -> [CategoryGroupPlain] {
        await categoryGroupsDataSourceLocal.categoryGroups()
    }
    
    func payees() async -> [PayeePlain] {
        await payeesDataSourceLocal.payees()
    }
}

final class LoadTransactionAccountsDataSource: LoadTransactionAccountsSource {
    let budgetAccountsDataSourceLocal: any BudgetAccountsDataSourceLocal = Container.shared.budgetAccountsDataSourceLocal()
    
    func accounts() async -> [BudgetAccountPlain] {
        await budgetAccountsDataSourceLocal.accounts()
    }
}
