//
//  AddTransactionDataSource.swift
//  Budgetary
//
//  Created by Phillip Baker on 21/05/2025.
//

import Factory

final class AddTransactionDataSource: AddTransactionSource {
    let budgetAccountsDataSourceLocal: BudgetAccountsDataSourceLocal = Container.shared.budgetAccountsDataSourceLocal()
    let payeesDataSourceLocal: PayeesDataSourceLocal = Container.shared.payeesDataSourceLocal()
    let categoryGroupsDataSourceLocal: any CategoryGroupsDataSourceLocal = Container.shared.categoryGroupsDataSourceLocal()

    func getPayees() async -> [PayeePlain] {
        await payeesDataSourceLocal.allPayees()
    }

    func getAccounts() async -> [BudgetAccountPlain] {
        await budgetAccountsDataSourceLocal.allBudgetAccounts()
    }

    func getCategoryGroups() async -> [CategoryGroupPlain] {
        await categoryGroupsDataSourceLocal.allCategoryGroups()
    }

    func update(account: BudgetAccountPlain) async {
        await budgetAccountsDataSourceLocal.update(budgetAccount: account)
    }
}
