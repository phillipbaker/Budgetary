//
//  LoadBudgetAccountsDataSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 21/05/2025.
//

import Factory

final class LoadBudgetAccountsDataSource: LoadBudgetAccountsSource {
    let budgetAccountsDataSourceLocal: any BudgetAccountsDataSourceLocal = Container.shared.budgetAccountsDataSourceLocal()
    let categoryGroupsDataSourceLocal: any CategoryGroupsDataSourceLocal = Container.shared.categoryGroupsDataSourceLocal()
    let payeesDataSourceLocal: any PayeesDataSourceLocal = Container.shared.payeesDataSourceLocal()
    
    func loadBudgetAccounts() async -> [BudgetAccountPlain] {
        await budgetAccountsDataSourceLocal.loadBudgetAccounts()
    }
    
    func loadCategoryGroups() async -> [CategoryGroupPlain] {
        await categoryGroupsDataSourceLocal.loadCategoryGroups()
    }
    
    func loadPayees() async -> [PayeePlain] {
        await payeesDataSourceLocal.loadPayees()
    }
}
